#include <CUnit/Basic.h>
#include <CUnit/CUnit.h>
#include <stdio.h>

#include "codif.h"
#include "streamencode.h"

static morse_char_t m;
static morse_table_t tm;
static char char1;
static char char2;
static char char3;
static int s;
FILE* in;
FILE* out;

void init_modul_codif(void){
  empty_morse_table(tm);
  int i;
  for (i=0;i<64; i++) {
    CU_ASSERT_TRUE(tm[i] == '@');
  }
}

void test_set_translation(void){
  empty_morse_table(tm);
  set_translation(tm, 'T', "-");
  set_translation(tm, 'E', ".");
  set_translation(tm, 'A', ".-");
  CU_ASSERT_TRUE(tm[2]=='E');
  CU_ASSERT_TRUE(tm[3]=='T');
  CU_ASSERT_TRUE(tm[5]=='A');
  
}

void test_to_ascii(void){

  char1 = to_ascii(tm,".-");
  CU_ASSERT_EQUAL(char1,'A');

  char2 = to_ascii(tm,"-");
  CU_ASSERT_EQUAL(char2,'T');

  char3 = to_ascii(tm,".");
  CU_ASSERT_EQUAL(char3,'E');
}
  

void test_to_morse(void){
  to_morse(tm,'A',m);
  printf("Valor: %c",m[0]);
  CU_ASSERT_EQUAL(m[0],'.');
  CU_ASSERT_EQUAL(m[1],'-');
  to_morse(tm,'T',m);
  CU_ASSERT_EQUAL(m[0],'-');
  to_morse(tm,'E',m);
  CU_ASSERT_EQUAL(m[0],'.');
  //to_morse();
}

void test_do_codifica(void){
  char d;
  streamencoder_init();
  in=tmpfile();
  out=tmpfile();
  fseek(in,0,SEEK_SET);
  fputs("T",in);
  do_codifica(in,out);
  fseek(out,0,SEEK_SET);
  CU_ASSERT_EQUAL(getc(out),'-');
  fclose(in);
  fclose(out);

}

void test_do_descodifica(void){
  in=tmpfile();
  out=tmpfile();
  fseek(in,0,SEEK_SET);
  fputs("...",in);
  do_descodifica(in,out);
  fseek(out,0,SEEK_SET);
  CU_ASSERT_EQUAL(getc(out),'S');
  
}

/* The main() function for setting up and running the tests.
 * Returns a CUE_SUCCESS on successful running, another
 * CUnit error code on failure.
 */

int main() {
  CU_pSuite pSuite1 = NULL;
  CU_pSuite pSuite2 = NULL;

   /* initialize the CUnit test registry */
   if (CUE_SUCCESS != CU_initialize_registry())
      return CU_get_error();

   //modul CODIF

   /* add a suite to the registry */
   pSuite1 = CU_add_suite("Modul codif", NULL, NULL);
   if (NULL == pSuite1) {
      CU_cleanup_registry();
      return CU_get_error();
   }
   pSuite2 = CU_add_suite("Modul streamencode", NULL, NULL);
   if (NULL == pSuite2) {
      CU_cleanup_registry();
      return CU_get_error();
   }

   /* add the tests to the suite */
   CU_add_test(pSuite1, "test of empty", init_modul_codif);
   CU_add_test(pSuite1, "test of set_translation", test_set_translation);
   CU_add_test(pSuite1, "test of to_ascii", test_to_ascii);
   CU_add_test(pSuite1, "test of to_morse", test_to_morse);
   CU_add_test(pSuite2, "test of do_codifica", test_do_codifica);
   CU_add_test(pSuite2, "test of do_descodifica", test_do_descodifica);

   /* Run all tests using the CUnit Basic interface */
   CU_basic_set_mode(CU_BRM_VERBOSE);
   CU_basic_run_tests();
   CU_cleanup_registry();

   return CU_get_error();
}
