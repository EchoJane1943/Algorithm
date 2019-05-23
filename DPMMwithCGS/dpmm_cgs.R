# 生成多维高斯混合分布数据
set.seed(2019)
gene_data <- function(n,p){
  # n: length of data
  # p: dimention of x
  # rho: Covariance matrix correlation
  rho       <- runif(p,0,1)
  w         <- DIRECT::rDirichlet(1,rep(1,p)) # weights of every distribution
  x         <- data.frame()
  means     <- list()
  sigmas    <- list()
  for (i in (1:p)) {
    n_samples <- ceiling(n*w[i])
    mean      <- rnorm(p,0,1)
    sigma_mat <- function(p,rho){diag(1-rho,p,p)+rho}
    sigma     <- sigma_mat(p,rho[i])
    temp      <- MASS::mvrnorm(n_samples, mean, sigma)
    x         <- rbind(x,temp)
    means     <- c(means,list(mean))
    sigmas    <- c(sigmas,list(sigma))
  }
  return(list(x = x[1:n,],w = w,means = means,sigma = sigmas,rho = rho))
}

result <- gene_data(50,5)


# DPMM and CGS

get_n_k_i <- function(arr,i,k){
  mat <-  as.data.frame(table(arr[1:i]),names=c("Var1","Freq"))
  res <- ifelse(i<1,0,mat$Freq[mat$Var1==k])
  return(res)
}

crp_cgs <- function(x,T = 1,alpha = 1){
  
  # xi: data
  # zi: clusters
  
  Phi <- function(nk,i.=i,Phi0.=Phi0,lambda.=lambda,mu0.=mu0,x_bar.=x_bar,x.=x){
    munk <- (lambda.*mu0.+nk*x_bar.)/(lambda.+nk)
    res  <- Phi0.+lambda.*mu0.%*%t(mu0.)-(lambda.+nk)*(munk)%*%t(munk)
    for(j in 1:i){res = res+as.matrix(t(x.[i,]))%*%as.matrix(x.[i,])}
    return(res)
  }
  
  N = dim(x)[1]
  D = dim(x)[2]
  K = 5
  Z      <- sample(c(1:K),size = N,replace = TRUE)
  mat    <-  as.data.frame(table(Z),names=c("Var1","Freq"))
  lambda <- 10
  nu     <- 10
  mu0    <- rep(10,D)
  Phi0   <- diag(10,D)
  for (t in 1:T) {
    print(t)
    for (i in 1:N) {
      
      cat("i=",i,"\n")
      p1 = c()
      p2 = c()
      p3 = c()
      x_bar = colMeans(x[1:i,])
      
      for (k in 1:K) {
        
        # p(z_i=k|z_-i,alpha) == p1
        p1tem = get_n_k_i(Z,i-1,k)/(i-1+alpha)
        p1=c(p1,p1tem)
        cat("p1=",p1,"\n")
        
        # p(x_i|x_-i,k,Phi) == p2
        
        nk = get_n_k_i(Z,i,k)
        
        p2tem = pi^(-D/2)*((lambda+nk)/(lambda+nk-1))^(-D/2)*
          det(Phi(nk))^(-(nu+nk)/2)/det(Phi(nk-1))^(-(nu+nk-1)/2)*
          gamma((nu+nk)/2)/gamma((nu+nk-D)/2)
        p2 = c(p2,p2tem)
        cat("p2=",p2,"\n")
        
        # p(z_i=k|z_-i,x_i,alpha,Phi)== p3
        p3tem = p1tem * p2tem
        p3 = c(p3,p3tem)
        cat("p3=",p3,"\n")
        
      }
      
      p1tem =alpha/(i-1+alpha)
      p1 = c(p1,log(p1tem))
      
      p2tem = pi^(-D/2)*((lambda+1)/(lambda+1-1))^(-D/2)*
        det(Phi(1))^(-(nu+1)/2)/det(Phi(1-1))^(-(nu+1-1)/2)*
        gamma((nu+1)/2)/gamma((nu+1-D)/2)
      p2 = c(p2,log(p2tem))
      
      p3tem = p1tem * p2tem
      p3 = c(p3,p3tem)
    }
    print(p3)
    print(K)
    Z <- sample(1:(K+1),size = N,replace = TRUE,prob = p3)
    K = length(unique(Z))
  }
  return(Z)
}

res <- crp_cgs(result$x)
