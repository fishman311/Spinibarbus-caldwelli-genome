project.name<-"polyploy_constrained"
data.path<-file.path("/assembly/lfj/TRACCER/01.orthofind/00.pep/OrthoFinder/Results_Apr24/Phylogenetic_Hierarchical_Orthogroups/PHO_2/13.4_species_ensemble_direct/constrained"
)
code.path<-"/mnt/lfj/soft/polysel/R"
empfdr.path<-"/assembly/lfj/TRACCER/01.orthofind/00.pep/OrthoFinder/Results_Apr24/Phylogenetic_Hierarchical_Orthogroups/PHO_2/13.4_species_ensemble_direct/constrained/empfdr"
results.path<-"/assembly/lfj/TRACCER/01.orthofind/00.pep/OrthoFinder/Results_Apr24/Phylogenetic_Hierarchical_Orthogroups/PHO_2/13.4_species_ensemble_direct/constrained/results"
source(file.path(code.path,'polysel.R'))
minsetsize<-3
maxsetsize<-100
result<-ReadSetObjTables(in.path=data.path,
                         set.info.file="SetInfo.txt",
                         set.obj.file="SetObj.txt",
                         obj.info.file="ObjInfo.txt",
                         minsetsize=minsetsize,
                         obj.in.set=F,
                         merge.similar.sets=T,maxsetsize=maxsetsize)
set.info<-result$set.info
obj.info<-result$obj.info
set.obj<-result$set.obj
set.info.lnk<-result$set.info.lnk

cat("Number of sets: ", nrow(set.info), "\n", sep="")


obj.stat<-obj.info[,c("objID", "objStat", "objBin")]
save(set.info, obj.info, obj.stat, set.obj, set.info.lnk,
     file=file.path(data.path, "polysel_objects.RData"))

approx.null <- TRUE
use.bins <- FALSE
seq.rnd.sampling <- TRUE
nrand <- 1000
test <- "highertail"
qvalue.method <- "bootstrap"
     
      
result<-EnrichmentAnalysis(set.info, set.obj, obj.stat,
                    nrand=nrand, approx.null=approx.null, 
                    seq.rnd.sampling=seq.rnd.sampling,
                    use.bins=use.bins, test=test,
                    do.pruning=FALSE, minsetsize=minsetsize,
                    project.txt=project.name, do.emp.fdr=FALSE,
                    qvalue.method=qvalue.method
                    )
set.scores.prepruning <- result$set.scores.prepruning
print(set.scores.prepruning[1:10,],row.names=F, right=F)
save(set.scores.prepruning, 
     file = file.path(results.path,
            paste(project.txt=project.name,
            "_setscores_prepruning_", 
            formatC(nrand,format="d"),".RData", sep="")))
write.table(set.scores.prepruning, quote=FALSE, sep="\t", row.names=FALSE, 
            file = file.path(results.path, paste(project.txt=project.name, 
                   "_setscores_prepruning_", formatC(nrand,format="d"),".txt",
                   sep="")))
nrand <- 1000000
result<-EnrichmentAnalysis(set.info, set.obj, obj.stat,
                    nrand=nrand, approx.null=approx.null, 
                    seq.rnd.sampling=seq.rnd.sampling,
                    use.bins=use.bins, test=test,
                    do.pruning=FALSE, minsetsize=minsetsize,
                    project.txt=project.name, do.emp.fdr=FALSE,
                    qvalue.method=qvalue.method
                    )
set.scores.prepruning <- result$set.scores.prepruning
print(set.scores.prepruning[1:10,],row.names=F, right=F)
save(set.scores.prepruning, 
     file = file.path(results.path,
            paste(project.txt=project.name,
            "_setscores_prepruning_", 
            formatC(nrand,format="d"),".RData", sep="")))

write.table(set.scores.prepruning, quote=FALSE, sep="\t", row.names=FALSE, 
            file = file.path(results.path, paste(project.txt=project.name, 
                   "_setscores_prepruning_", formatC(nrand,format="d"),".txt",
                   sep="")))
                   
                   
less polyploy_constrained_setscores_prepruning_1000000.txt | cut -f1,4 > tmp.txt
Rscript adjust_fdr.R --file tmp.txt --column 2
less tmp_with_BH.txt 
paste -d "\t" tmp_with_BH.txt polyploy_constrained_setscores_prepruning_1000000.txt | less
paste -d "\t" tmp_with_BH.txt polyploy_constrained_setscores_prepruning_1000000.txt | cut -f1-3,5,8-10 > polyploy_constrained_setscores_prepruning_1000000_BH.txt
                                                                                                                
