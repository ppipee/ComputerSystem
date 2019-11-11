//Simulates data cache with parameters read from "cache.config"

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

static int lscount; //total number of load/stores
static int wcount;  //number of writes
static int rcount;  //number of reads
static int wmiss;   //number of write misses;
static int rmiss;   //number of read misses;
static int wbs;     //number of write backs (i.e. write misses that point to dirty lines)

static int size;  // cache size
static int assoc; // associativity
static int block; // block size

static int bbits; // offset bits
static int ibits; // index bits
static int tbits; // tag bits

typedef struct
{
  char dirty;      //dirty bit
  char valid;      //valid bit
  unsigned int ts; //used for LRU policy
  int tag;         //tag
} entry;

static entry **cache;

void Initializing()
{

  FILE *f;
  int numsets, i, j; //number of sets in the cache

  lscount = 0;
  wmiss = 0;
  rmiss = 0;

  f = fopen("cache.config", "r");
  assert(NULL != f);
  assert(3 == fscanf(f, "%d %d %d", &size, &block, &assoc));
  fclose(f);

  //make sure all these are powers of two:
  if (!(block && ((block & (block - 1)) == 0)))
  {
    printf("Block size not power of 2\n");
    exit(0);
  }
  if (!(assoc && ((assoc & (assoc - 1)) == 0)))
  {
    printf("Associativity not power of 2\n");
    exit(0);
  }
  if (!(size && ((size & (size - 1)) == 0)))
  {
    printf("Cache size not a power of 2\n");
    exit(0);
  }

  numsets = ((size / block) / assoc);
  bbits = ibits = tbits = 0;
  // **Fill me in**
  // Code to calculate the number of bits for offset, index, and tag goes here
  int cp_block = block;
  int cp_size = size;
  while (cp_block > 1)
  {
    bbits++;
    cp_block = cp_block / 2;
  }
  while (cp_size > 1)
  {
    cp_size = cp_size / 2;
    ibits++;
  }
  ibits = ibits - bbits;
  tbits = 32 - (ibits + bbits);

  printf("bbits: %d ibits: %d tbits: %d\n", bbits, ibits, tbits);
  printf("numsets: %d\n", numsets);

  cache = (entry **)malloc(numsets * sizeof(entry *));
  assert(NULL != cache);
  for (i = 0; i < numsets; i++)
  {
    cache[i] = (entry *)malloc(assoc * sizeof(entry));
    for (j = 0; j < assoc; j++)
    {
      cache[i][j].dirty = 0;
      cache[i][j].valid = 0;
      cache[i][j].ts = 0;
      cache[i][j].tag = -1;
    }
  }
}

void CacheAccess(unsigned int v, int type)
{

  size_t start;
  int d_tag;
  int d_index;
  int d_offsets;

  lscount++;
  if (type == 0)
    rcount++;
  else
    wcount++;

  d_offsets = v & ((1 << bbits) - 1);                   //ignore
  start = ibits + bbits;                                //bit start = 12
  d_tag = (v & ((1 << tbits) - 1 << start)) >> start;   //select bits[12:31]
  start = bbits;                                        //bit start = 5
  d_index = (v & ((1 << ibits) - 1 << start)) >> start; //select bits[5:11]

  if (cache[d_index][0].tag != d_tag)
  {
    if (cache[d_index][0].dirty == 1)
      wbs++;
    if (type == 0)
    {
      rmiss++;
      cache[d_index][0].dirty = 0;
    }
    else
    {
      wmiss++;
      cache[d_index][0].dirty = 1;
    }
    cache[d_index][0].tag = d_tag;
    cache[d_index][0].valid = 1;
  }
}

void AfterProg(char *progname)
{
  FILE *f;
  char fname[256];

  sprintf(fname, "%s.cache", progname);
  f = fopen(fname, "w");
  assert(NULL != f);

  fprintf(f, "\n");
  fprintf(f, "Cache Parameters:\n");
  fprintf(f, "Cache Size: %d\n", size);
  fprintf(f, "Block Size: %d\n", block);
  fprintf(f, "Associativity: %d\n", assoc);
  fprintf(f, "\n");

  fprintf(f, "Total memory accesses: %d\n", lscount);
  fprintf(f, "Number of hits: %d\n", lscount - rmiss - wmiss);
  fprintf(f, "Number of read misses: %d\n", rmiss);
  fprintf(f, "Number of write misses: %d\n", wmiss);
  fprintf(f, "Number of write backs: %d\n", wbs);
  fprintf(f, "Overall miss ratio: %.5f\n", (100.0 * (rmiss + wmiss)) / lscount);
  fprintf(f, "Read miss ratio: %.5f\n", (100.0 * rmiss) / rcount);
  fprintf(f, "Write miss ratio: %.5f\n", (100.0 * wmiss) / wcount);

  fprintf(f, "\n");
  fclose(f);
}

int main(int argc, char **argv)
{
  FILE *f;
  unsigned int address;
  int type, i;
  char t1[2];

  Initializing();
  f = fopen(argv[1], "r");
  assert(NULL != f);
  while (fscanf(f, "%s %x", t1, &address) == 2)
  {
    if (t1[0] == 'R')
      type = 0;
    else
      type = 1;
    CacheAccess(address, type);
  }
  AfterProg("matrix");
  fclose(f);
  return 0;
}
