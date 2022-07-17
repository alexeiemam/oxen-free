# The app requires an API to connect to
# By parsing it in an initialiser
# We ensure the app will fail to start if an invalid URL is configured
ARTICLE_API_ENDPOINT =
  URI(
    ENV.fetch('ARTICLE_API_ENDPOINT') {
      'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'
    }
  )
