#include <R.h>
#include <Rinternals.h>
#include <Rinterface.h>
#include <R_ext/Rdynload.h>

SEXP interactivity (SEXP tf){
	SEXP newTF;
	if (!isLogical(tf) || LENGTH(tf) < 1){
		warning("Argument must be type logical");
	} else {
		R_Interactive = LOGICAL(tf)[0];
	}

	PROTECT(newTF = allocVector(LGLSXP,1));
	LOGICAL(newTF)[0] = R_Interactive;
	UNPROTECT(1);
	return newTF;
}

R_CallMethodDef callMethods[]  = {
	{"interactivity", (DL_FUNC) &interactivity, 1},
	{NULL, NULL, 0}
};

void R_init_mylib(DllInfo *info){
	R_registerRoutines(info,NULL,callMethods,NULL,NULL);
}
