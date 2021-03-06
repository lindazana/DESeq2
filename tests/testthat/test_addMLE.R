context("addMLE")
test_that("adding MLE works as expected", {
  set.seed(1)
  dds <- makeExampleDESeqDataSet(n=200,m=12,betaSD=1)
  dds$condition <- factor(rep(letters[1:3],each=4))
  dds <- DESeq(dds, betaPrior=TRUE)
  ddsNP <- nbinomWaldTest(dds, betaPrior=FALSE)

  res1 <- results(dds, contrast=c("condition","c","a"), addMLE=TRUE)
  res2 <- results(ddsNP, contrast=c("condition","c","a"))
  expect_equal(res1$lfcMLE, res2$log2FoldChange)

  res1 <- results(dds, contrast=c("condition","a","b"), addMLE=TRUE)
  res2 <- results(ddsNP, contrast=c("condition","a","b"))
  expect_equal(res1$lfcMLE, res2$log2FoldChange)

  res1 <- results(dds, contrast=c("condition","c","b"), addMLE=TRUE)
  res2 <- results(ddsNP, contrast=c("condition","c","b"))
  expect_equal(res1$lfcMLE, res2$log2FoldChange)
})
