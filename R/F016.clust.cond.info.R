#' Calculate cluster and conditions frequencies
#'
#' This function takes an object of class iCellR and calculates cluster and conditions frequencies.
#' @param x An object of class iCellR.
#' @param plot.type Choose from pie or bar, defult = pie.
#' @param my.out.put Chose from "data" or "plot", default = "data".
#' @param normalize.ncell If TRUE the values will be normalized to the number of cells by downsampling.
#' @return An object of class iCellR.
#' @examples
#' clust.cond.info(demo.obj, plot.type = "pie", normalize.ncell = TRUE, my.out.put = "data")
#'
#' head(demo.obj@my.freq)
#'
#' clust.cond.info(demo.obj, plot.type = "pie", normalize.ncell = TRUE, my.out.put = "plot")
#' @export
clust.cond.info <- function (x = NULL,
                             plot.type = "pie",
                             my.out.put = "data",
                             normalize.ncell = TRUE) {
  if ("iCellR" != class(x)[1]) {
    stop("x should be an object of class iCellR")
  }
  ###################
  Cells <- colnames(x@main.data)
  MYConds <- as.character((unique(data.frame(do.call('rbind', strsplit(as.character(Cells),'_',fixed=TRUE)))[1]))$X1)
  if (length(MYConds) == 1) {
    stop("You need more then one condition/sample to run this function")
  }
  if (length(MYConds) == 0) {
    stop("You need more then one condition/sample to run this function")
  }
  ###################
  DATA <- (x@best.clust)
  Conds <- (as.data.frame(do.call("rbind", strsplit(row.names(DATA), "_")))[1])
  ForNorm1 <- as.data.frame(table(Conds))
  ForNorm <- min(ForNorm1$Freq)
  clusts <- (as.data.frame(DATA$clusters))
  cond.clust <- cbind(Conds, clusts)
  colnames(cond.clust) <- c("conditions","clusters")
  Conds <- as.character(ForNorm1$Conds)
  My.Conds.data <- cond.clust
  for (i in Conds) {
    NameCol <- paste("My_Cond",i,sep="_")
    myDATA <- head(subset(My.Conds.data, My.Conds.data$conditions == i),ForNorm)
    eval(call("<-", as.name(NameCol), myDATA))
  }
  filenames <- ls(pattern="My_Cond_")
  datalist <- mget(filenames)
  NormDATA <- do.call(rbind.data.frame,datalist)
  if (normalize.ncell == TRUE) {
    cond.clust <- NormDATA
  }
  DATA <- as.data.frame(table(cond.clust))
  Freq <- DATA$Freq
  if (normalize.ncell == TRUE) {
    colnames(DATA) <- c("conditions","clusters","NormalizedFreq")
  }
# as.data.frame(table(Conds))
  # bar
  myBP <- ggplot(DATA,aes(y=Freq, x=clusters, fill = conditions)) +
   geom_bar(stat = "identity") + theme_bw() + theme(axis.text.x=element_text(angle=90))
  # pie
  myPIE <- ggplot(DATA,aes(y=Freq, x="", fill = conditions)) +
    geom_bar(stat = "identity", position = "fill") + theme_bw() + facet_wrap(~ clusters) +
      theme(axis.title.y=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks.y=element_blank()) + coord_polar(theta="y")
  #############
#  write.table((DATA), file="clust_cond_freq_info.txt", sep="\t", row.names =FALSE)
#  message("clust_cond_freq_info.txt file has beed generated.")
  if (my.out.put == "plot") {
    if (plot.type == "bar") {
      return(myBP)
    }
    if (plot.type == "pie") {
      return(myPIE)
    }
  }
#
  if (my.out.put == "data") {
    attributes(x)$my.freq <- DATA
    return(x)
  }
}
