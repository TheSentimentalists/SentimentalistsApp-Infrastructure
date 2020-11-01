resource "aws_lambda_function" "lambda" {
  function_name = "app-${var.lambda_name}-${var.lambda_stage}"
  handler       = var.lambda_handler
  runtime       = "python3.8"
  timeout       = 30
  memory_size   = 256

  s3_bucket = var.s3_bucket
  s3_key    = var.s3_key

  role = aws_iam_role.lambda_exec.arn
}

resource "aws_iam_role" "lambda_exec" {
  name = "role-${var.lambda_name}-${var.lambda_stage}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "lambda_exec" {
  name = "test_policy"
  role = aws_iam_role.lambda_exec.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": [
                "arn:aws:secretsmanager:eu-west-2:481434056562:secret:prod/getCredibilityScore/GATEKey-uRdNls",
                "arn:aws:secretsmanager:eu-west-2:481434056562:secret:prod/test-mXktSh"
            ]
      },
      {
            "Effect": "Allow",
            "Action": "logs:CreateLogGroup",
            "Resource": "arn:aws:logs:eu-west-2:481434056562:*"
      },
      {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:eu-west-2:481434056562:log-group:*"
            ]
      }

    ]
  }
  EOF
}
