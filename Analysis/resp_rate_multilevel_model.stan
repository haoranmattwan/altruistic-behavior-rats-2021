
data {
    int<lower=1> N;
    int<lower=1> S;
    array[N] int<lower=1> subID;
    int<lower=1> C;
    array[N] int<lower=1> condID;
    array[N] int<lower=0> FC;
    array[N] int SC;
}
parameters {
    matrix[2*C, S] z;
    cholesky_factor_corr[2*C] L_Omega;
    vector<lower=0>[2*C] tau;
    row_vector[2*C] gamma;
    real<lower=0> overdisp;
}
transformed parameters {
    matrix[S, 2*C] beta;
    beta = rep_matrix(gamma, S) + (diag_pre_multiply(tau, L_Omega) * z)';
}
model {
    to_vector(z) ~ std_normal();
    L_Omega ~ lkj_corr_cholesky(2);
    tau ~ exponential(1.5);
    to_vector(gamma) ~ normal(1, 1.5);
    overdisp ~ exponential(1);
    
    for (n in 1:N) {
      FC[n] ~ neg_binomial_2_log(beta[subID[n], condID[n]], overdisp);
      if (SC[n] >= 0) {
        SC[n] ~ neg_binomial_2_log(beta[subID[n], condID[n] + C], overdisp);
      }
    }
}
