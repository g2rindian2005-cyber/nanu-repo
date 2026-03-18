

# --------------------
# S3 Bucket
# --------------------
resource "aws_s3_bucket" "bucket" {
  bucket = "gokul-lambda-bucket-12345"
}

# --------------------
# Upload ZIP to S3
# --------------------
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.bucket.id
  key    = "lambda_function.zip"
  source = "lambda_function.zip"
}

# --------------------
# IAM Role for Lambda
# --------------------
resource "aws_iam_role" "lambda_role" {
  name = "lambda_exec_role_gokul"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# Attach policy
resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# --------------------
# Lambda Function
# --------------------
resource "aws_lambda_function" "lambda" {
  function_name = "gokul_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"

  s3_bucket = aws_s3_bucket.bucket.id
  s3_key    = aws_s3_object.lambda_zip.key
}

# --------------------
# API Gateway
# --------------------
resource "aws_apigatewayv2_api" "api" {
  name          = "gokul_api"
  protocol_type = "HTTP"
}

# Integration
resource "aws_apigatewayv2_integration" "integration" {
  api_id           = aws_apigatewayv2_api.api.id
  integration_type = "AWS_PROXY"

  integration_uri = aws_lambda_function.lambda.invoke_arn
}

# Route
resource "aws_apigatewayv2_route" "route" {
  api_id    = aws_apigatewayv2_api.api.id
  route_key = "GET /hello"

  target = "integrations/${aws_apigatewayv2_integration.integration.id}"
}

# Stage
resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true
}

# अनुमति for API to call Lambda
resource "aws_lambda_permission" "api" {
  statement_id  = "AllowExecutionFromAPI"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"
}