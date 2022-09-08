output "all_arns" {
  value       = aws_iam_user.example[*]
  description = "The ARNs for all users"
}
