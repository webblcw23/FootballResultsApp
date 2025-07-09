# root 
# calling variable values from separate module folders through output -> variable. This is for best structure practice 

module "vpc" {
    source = "./vpc"
    
}   

module "ec2" {
    source = "./web"

    sg = module.vpc.sg
    sn = module.vpc.sn   
}