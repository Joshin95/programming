#ifndef SHRTBL_H
#define SHRTBL_H

#define NR_PARTITS 20

typedef void travapp(const char *const id, int votes, void *const data);

typedef struct{
  char nom_part[16];
  int vots;
} partit;

typedef struct{
  partit taula[NR_PARTITS];
  int nr;
} taula_part;

int create_shared_table(void);
int remove_shared_table(void);
int bind_shared_table(void);
void init_table(void);
int add_party(const char id[]);
void del_party(const char id[]);
void inc_votes(const char party[], int votes);
int get_votes(const char party[]);
int get_nparties(void);
void traverse(travapp *const f, void *const data);

#endif
