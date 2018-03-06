
output "nacl-rules"
{
    value  = "${data.null_data_source.ingress-join.*.outputs}"
}
