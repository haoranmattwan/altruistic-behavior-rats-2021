
data {
  int<lower=1> N;
  int<lower=1> S;
  array[N] int<lower=1> subID;
  int<lower=1> C;
  array[N] int<lower=1> condID;
  array[N] int<lower=0> CP;      // Consumed Pellets (counts)
  array[N] int LP;               // Left-behind Pellets (counts), allows -1 for NA
  array[N] int SP;               // Shared Pellets (counts), allows -1 for NA
}

parameters {
  // Parameters for the hierarchical structure (3*C for Consumed, Left, and Shared)
  matrix[3*C, S] z;
  cholesky_factor_corr[3*C] L_Omega;
  vector<lower=0>[3*C] tau;
  row_vector[3*C] gamma;
  real<lower=0> overdisp;
}

transformed parameters {
  // Calculate subject-specific log-rates (beta) for each outcome type and condition
  matrix[S, 3*C] beta = rep_matrix(gamma, S) + (diag_pre_multiply(tau, L_Omega) * z)';
}

model {
  // Priors
  to_vector(z) ~ std_normal();
  L_Omega ~ lkj_corr_cholesky(2);
  tau ~ exponential(1.5);
  to_vector(gamma) ~ normal(0, 1.5); // Prior centered at log(1) = 0 pellets
  overdisp ~ exponential(1);

  // Likelihood
  for (n in 1:N) {
    CP[n] ~ neg_binomial_2_log(beta[subID[n], condID[n]], overdisp);
    if (LP[n] >= 0) {
      LP[n] ~ neg_binomial_2_log(beta[subID[n], condID[n] + C], overdisp);
    }
    if (SP[n] >= 0) {
      SP[n] ~ neg_binomial_2_log(beta[subID[n], condID[n] + (2*C)], overdisp);
    }
  }
}
