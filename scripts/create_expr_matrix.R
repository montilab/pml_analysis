#Create .txt files to upload on GSE
PATH <- getwd()

eset <- readRDS(file.path(PATH, "data/2021_08_20_eset_imputed.RDS"))
eSet_wo_infl <- eset[, which(pData(eset)$Class != 'Inflammatory')]

## Host
# Raw Expression Matrix
expr <- as.matrix(exprs(eSet_wo_infl))
write.table(expr, file.path(PATH, "data/2023_20_03_expr_mat_raw.txt"))

# CPM_normalised
cpm_eset <- eSet_wo_infl
exprs(cpm_eset) <- apply(exprs(cpm_eset), 2, function(x) {x/(sum(x)/1000000)})

expr <- as.matrix(exprs(cpm_eset))
write.table(expr, file.path(PATH, "data/2023_20_03_expr_mat_cpm.txt"))

## Microbiome
MAE <- readRDS(file.path(PATH, "data/animalcules_data_2022-03-14.rds"))
microbe <- MAE[["MicrobeGenetics"]]
tax_table <- as.data.frame(rowData(microbe))
sam_table <- as.data.frame(colData(microbe))
counts_table <- as.data.frame(assays(microbe))[, rownames(sam_table)]

write.table(counts_table, file.path(PATH, "data/2023_20_03_expr_mat_microbe.txt"))
