variable "region" {
    default = "ap-south-1"
}
variable "cluster_name" {
    default = "product-catalog-cluster"
}
variable "node_group_name" {
    default = "product-catalog-node-group"
}
variable "instance_type" {
    default = "t3.small"
}
variable "desired_size" {
    default = 2
}
variable "max_size" {
    default = 3
}
variable "min_size" {
    default = 1
}