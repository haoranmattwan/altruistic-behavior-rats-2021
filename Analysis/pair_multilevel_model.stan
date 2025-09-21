
data{
	int<lower=1> N;         // Number of observations
	int<lower=1> S;         // Number of subjects
	array[N] int<lower=1> subID;  // Subject IDs
	int<lower=1> C;         // Number of conditions
	array[N] int<lower=1> condID; // Condition ID
	array[N] int<lower=0> choice; // Number of choices per session
	array[N] int<lower=0> food;   // Number of food choices (such that choose[s]-food[s]=social[s])
}
//
transformed data {
	vector[S] u;
	for (s in 1:S) {
		u[s] = 1;
	}
}
//
parameters{
	matrix[C, S] z;                   // beta proxy
	cholesky_factor_corr[C] L_Omega;  // prior correlation
	vector<lower=0>[C] tau;           // prior scale
	row_vector[C] gamma;              // population means
}
//
transformed parameters{
	matrix[S,C] beta;                 // individual coefficients for each subject in each condition
	beta = u * gamma + (diag_pre_multiply(tau,L_Omega) * z)';
}
//
model{
	array[N] real mu;

	to_vector(z) ~ normal(0,1);
	L_Omega ~ lkj_corr_cholesky(2);
	tau ~ exponential(1.5);
	to_vector(gamma) ~ normal(0,1.5);

	for ( n in 1:N ) {
		mu[n] = beta[subID[n],condID[n]];
	}
	food ~ binomial_logit(choice,mu);
}
