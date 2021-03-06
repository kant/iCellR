setClass("iCellR", representation (raw.data = "data.frame",
                                   main.data = "data.frame",
                                   imputed.data = "data.frame",
                                   scaled.data = "data.frame",
                                   stats = "data.frame",
                                   my.filters = "character",
                                   gene.model = "character",
                                   my.freq = "data.frame",
                                   obj.info = "character",
                                   vdj.data = "data.frame",
                                   tsne.data = "data.frame",
                                   umap.data = "data.frame",
                                   diffusion.data = "data.frame",
                                   pca.data = "data.frame",
                                   pca.info = "list",
                                   cca.data = "data.frame",
                                   opt.pcs = "numeric",
                                   dist.data = "data.frame",
                                   pseudo.mapA = "data.frame",
                                   pseudo.mapB = "data.frame",
                                   tsne.data.3d = "data.frame",
                                   clust.avg = "data.frame",
                                   gene.data = "data.frame",
                                   adt.raw = "data.frame",
                                   adt.main = "data.frame",
                                   clust.cond.freq = "data.frame",
                                   cluster.data = "list",
                                   best.clust = "data.frame",
                                   data.conditions = "character",
                                   norm.factors = "data.frame"))
# hide slots
setMethod("show",
          "iCellR",
          function(object){
            message("###################################","")
            message(",--. ,-----.       ,--.,--.,------. ","")
            message("`--''  .--./ ,---. |  ||  ||  .--. ' ","")
            message(",--.|  |    | .-. :|  ||  ||  '--'.' ","")
            message("|  |'  '--'\\   --. |  ||  ||  |\  \ ","")
            message("`--' `-----' `----'`--'`--'`--' '--' ","")
            message("###################################","")
            message(object@obj.info,"")
            message("###################################","")
            message("   QC stats performed:",dim(object@stats)[1] != 0,", ","PCA performed:",dim(object@pca.data)[1] != 0,", ","CCA performed:",dim(object@cca.data)[1] != 0)
            message("   Clustering performed:",!is.null(object@best.clust$clusters),", ","Number of clusters:",length(unique(object@best.clust$clusters)))
            message("   tSNE performed:",dim(object@tsne.data)[1] != 0,", ","UMAP performed:",dim(object@umap.data)[1] != 0,", ","DiffMap performed:",dim(object@diffusion.data)[1] != 0)
            message("   Main data dimentions (rows,columns):",dim(object@main.data)[1],",",dim(object@main.data)[2])
            message("   Normalization factors:",head(object@norm.factors,1),",","... ")
            message("   Imputed data dimentions (rows,columns):",dim(object@imputed.data)[1],",",dim(object@imputed.data)[2])
            message("############## scVDJ-Seq ###########","")
            message("VDJ data dimentions (rows,columns):",dim(object@vdj.data)[1],",",dim(object@vdj.data)[2])
            message("############## CITE-Seq ############","")
            message("   ADT raw data dimentions (rows,columns):",dim(object@adt.raw)[1],",",dim(object@adt.raw)[2])
            message("   ADT main data dimentions (rows,columns):",dim(object@adt.main)[1],",",dim(object@adt.main)[2])
            message("   ADT columns names:",head(colnames(object@adt.main),1),"... ")
            message("   ADT row names:",head(row.names(object@adt.main),1),"... ")
            message("########### iCellR object ##########","")
          })
