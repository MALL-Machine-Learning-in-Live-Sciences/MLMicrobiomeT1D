#########################################################################################################################
varImp.glmnet = function(bmr, n.model){  
  models = getBMRModels(bmr)
  glmnet = models[[n.model]]$classif.glmnet.tuned #El nimero en models hace referecncia a la tanda de modelos de difernte numero de features es decir 2,4,6,7..               ,
  sum.betas = rep(0)
  for (model in 1:length(glmnet)) {
    learner.models = getLearnerModel(glmnet[[model]])
    sum.betas = sum.betas + as.vector((learner.models$learner.model$beta))
  }
  names(sum.betas) = glmnet[[n.model]]$features
  barplot(abs(sum.betas), main = 'Glmnet Variable Importance', xaxt = "n", ylim = c(0,10), col = topo.colors(length(sum.betas)))
  return(sum.betas)
}

###################################################################################################################
varImp.rf = function(bmr, n.model){
  models = getBMRModels(bmr)
  rf = models[[n.model]]$classif.randomForest.tuned
  sum.imp = rep(0)
  for (i in 1:length(rf)) {
    iters = getFeatureImportance(rf[[i]])
    res = as.matrix(iters$res)
    sum.imp =+ sum.imp + res
  }
  print(length(sum.imp))
  barplot(sum.imp, main = 'Random Forest Variable Importance', xaxt = "n", col = topo.colors(length(sum.imp)))
  return(sum.imp)
}