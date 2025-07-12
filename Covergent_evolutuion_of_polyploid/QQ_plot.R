cyp_polyploid <- read.table("D:/TRACCER/dre_outgroup_accelerated.TRACCER.txt", sep="\t", header = TRUE)
a <- cyp_polyploid[,6]
y <- -log10(a)
y <- sort(y,decreasing = T)
x <- -log10(ppoints(length(y)))
control <- read.table("D:/TRACCER/dre_outgroup_random_control_accelerated.TRACCER.txt", sep="\t", header = TRUE)
b <- control[, 6]
y2 <- -log10(b)
y2 <- sort(y2,decreasing = T)
x2 <- -log10(ppoints(length(y2)))
plot(x, y, pch=19, axes = FALSE, xlim = c(0, 5), ylim = c(0, 5), col = c("skyblue"), cex = 0.5,
     +      xlab = expression(paste("Expected -log[10](permulation p-value)")),
     +      ylab = expression(paste("Observed -log[10](permulation p-value)")))
points(x2, y2, pch =19, col = c("orange"),cex = 0.5)
