#include <R.h>
#include <Rinternals.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Call calls */
extern SEXP R_aa_change_hat(SEXP, SEXP);
extern SEXP R_aa_change_profile(SEXP);
extern SEXP R_aa_find_mountpoint(void);
extern SEXP R_aa_getcon(void);
extern SEXP R_aa_is_compiled(void);
extern SEXP R_aa_is_enabled(void);
extern SEXP R_aa_revert_hat(SEXP);
extern SEXP R_getaffinity(void);
extern SEXP R_getaffinity_count(void);
extern SEXP R_has_affinity(void);
extern SEXP R_ncores(void);
extern SEXP R_setaffinity(SEXP);

static const R_CallMethodDef CallEntries[] = {
    {"R_aa_change_hat",      (DL_FUNC) &R_aa_change_hat,      2},
    {"R_aa_change_profile",  (DL_FUNC) &R_aa_change_profile,  1},
    {"R_aa_find_mountpoint", (DL_FUNC) &R_aa_find_mountpoint, 0},
    {"R_aa_getcon",          (DL_FUNC) &R_aa_getcon,          0},
    {"R_aa_is_compiled",     (DL_FUNC) &R_aa_is_compiled,     0},
    {"R_aa_is_enabled",      (DL_FUNC) &R_aa_is_enabled,      0},
    {"R_aa_revert_hat",      (DL_FUNC) &R_aa_revert_hat,      1},
    {"R_getaffinity",        (DL_FUNC) &R_getaffinity,        0},
    {"R_getaffinity_count",  (DL_FUNC) &R_getaffinity_count,  0},
    {"R_has_affinity",       (DL_FUNC) &R_has_affinity,       0},
    {"R_ncores",             (DL_FUNC) &R_ncores,             0},
    {"R_setaffinity",        (DL_FUNC) &R_setaffinity,        1},
    {NULL, NULL, 0}
};

void R_init_RAppArmor(DllInfo *dll){
    R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
