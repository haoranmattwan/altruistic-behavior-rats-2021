
data {
  int<lower=1> N;                // Number of observations (sessions)
  int<lower=1> S;                // Number of subjects (rats)
  array[N] int<lower=1> subID;   // Subject ID for each observation
  int<lower=1> C;                // Number of conditions (excluding Cond 5)
  array[N] int<lower=1> condID;  // Condition ID for each observation (re-indexed)
  array[N] int<lower=0> choice;  // Total choices (Food + Social) in session
  array[N] int<lower=0> food;    // Number of food choices in session
}

transformed data {
  // Vector of ones for simpler matrix math in beta calculation
  vector[S] u = rep_vector(1.0, S); 
}

parameters {
  // Parameters for the hierarchical structure (non-centered parameterization)
  matrix[C, S] z;                   // Standardized subject deviations
  cholesky_factor_corr[C] L_Omega;  // Cholesky factor of the correlation matrix for varying effects
  vector<lower=0>[C] tau;           // Scale parameters for varying effects (subject SDs per condition)
  row_vector[C] gamma;              // Population-level intercepts (mean log-odds per condition)
}

transformed parameters {
  // Calculate subject-specific intercepts (beta) for each condition
  // beta = population_mean + subject_deviation
  matrix[S, C] beta = u * gamma + (diag_pre_multiply(tau, L_Omega) * z)';
}

model {
  // --- Priors ---
  // Weakly informative priors
  to_vector(z) ~ std_normal();         // Standard normal for standardized deviations
  L_Omega ~ lkj_corr_cholesky(2);     // LKJ prior for correlation matrix
  tau ~ exponential(1.5);             // Exponential prior for scale parameters
  to_vector(gamma) ~ normal(0, 1.5);  // Normal prior for population means

  // --- Likelihood ---
  // The number of food choices follows a binomial distribution with a logit link.
  array[N] real mu;                   // Linear predictor on the logit scale
  for (n in 1:N) {
    mu[n] = beta[subID[n], condID[n]]; // Get the appropriate intercept
  }
  food ~ binomial_logit(choice, mu); 
}
