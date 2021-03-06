% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/categorical-distribution.R
\name{Categorical}
\alias{Categorical}
\alias{dcat}
\alias{pcat}
\alias{qcat}
\alias{rcat}
\alias{rcatlp}
\title{Categorical distribution}
\usage{
dcat(x, prob, log = FALSE)

pcat(q, prob, lower.tail = TRUE, log.p = FALSE)

qcat(p, prob, lower.tail = TRUE, log.p = FALSE, labels)

rcat(n, prob, labels)

rcatlp(n, log_prob, labels)
}
\arguments{
\item{x, q}{vector of quantiles.}

\item{prob, log_prob}{vector of length \eqn{m}, or \eqn{m}-column matrix
of non-negative weights (or their logarithms in \code{log_prob}).}

\item{log, log.p}{logical; if TRUE, probabilities p are given as log(p).}

\item{lower.tail}{logical; if TRUE (default), probabilities are \eqn{P[X \le x]}
otherwise, \eqn{P[X > x]}.}

\item{p}{vector of probabilities.}

\item{labels}{if provided, labeled \code{factor} vector is returned.
Number of labels needs to be the same as
number of categories (number of columns in prob).}

\item{n}{number of observations. If \code{length(n) > 1},
the length is taken to be the number required.}
}
\description{
Probability mass function, distribution function, quantile function and random generation
for the categorical distribution.
}
\details{
Probability mass function

\deqn{
\Pr(X = k) = \frac{w_k}{\sum_{j=1}^m w_j}
}{
Pr(X = k) = w[k]/sum(w)
}

Cumulative distribution function
\deqn{
\Pr(X \le k) = \frac{\sum_{i=1}^k w_i}{\sum_{j=1}^m w_j}
}{
Pr(X <= k) = sum(w[1:k])/sum(w)
}

It is possible to sample from categorical distribution parametrized
by vector of unnormalized log-probabilities
\eqn{\alpha_1,\dots,\alpha_m}{\alpha[1],...,\alpha[m]}
without leaving the log space by employing the Gumbel-max trick (Maddison, Tarlow and Minka, 2014).
If \eqn{g_1,\dots,g_m}{g[1],...,g[m]} are samples from Gumbel distribution with
cumulative distribution function \eqn{F(g) = \exp(-\exp(-g))}{F(g) = exp(-exp(-g))},
then \eqn{k = \mathrm{arg\,max}_i \{g_i + \alpha_i\}}{k = argmax(g[i]+\alpha[i])}
is a draw from categorical distribution parametrized by
vector of probabilities \eqn{p_1,\dots,p_m}{p[1]....,p[m]}, such that
\eqn{p_i = \exp(\alpha_i) / [\sum_{j=1}^m \exp(\alpha_j)]}{p[i] = exp(\alpha[i])/sum(exp(\alpha))}.
This is implemented in \code{rcatlp} function parametrized by vector of
log-probabilities \code{log_prob}.
}
\examples{

# Generating 10 random draws from categorical distribution
# with k=3 categories occuring with equal probabilities
# parametrized using a vector

rcat(10, c(1/3, 1/3, 1/3))

# or with k=5 categories parametrized using a matrix of probabilities
# (generated from Dirichlet distribution)

p <- rdirichlet(10, c(1, 1, 1, 1, 1))
rcat(10, p)

x <- rcat(1e5, c(0.2, 0.4, 0.3, 0.1))
plot(prop.table(table(x)), type = "h")
lines(0:5, dcat(0:5, c(0.2, 0.4, 0.3, 0.1)), col = "red")

p <- rdirichlet(1, rep(1, 20))
x <- rcat(1e5, matrix(rep(p, 2), nrow = 2, byrow = TRUE))
xx <- 0:21
plot(prop.table(table(x)))
lines(xx, dcat(xx, p), col = "red")

xx <- seq(0, 21, by = 0.01)
plot(ecdf(x))
lines(xx, pcat(xx, p), col = "red", lwd = 2)

pp <- seq(0, 1, by = 0.001)
plot(ecdf(x))
lines(qcat(pp, p), pp, col = "red", lwd = 2)

}
\references{
Maddison, C. J., Tarlow, D., & Minka, T. (2014). A* sampling.
[In:] Advances in Neural Information Processing Systems (pp. 3086-3094).
\url{https://arxiv.org/abs/1411.0030}
}
\concept{
Univariate

Discrete
}
\keyword{distribution}
