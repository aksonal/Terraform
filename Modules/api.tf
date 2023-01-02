module "myApi" {
   source = "./modules/API"  
   api_gateway_name = var.api_gateway_name
   method_1 = var.method_name
   api_stage = var.api_stage_name
   lambda_arn_for_api = module.myLambda.lambdaArn #fetches arn of lambda from path : modules/Lambda/output.tf 
}