
context("Example of a test")

test_that("Can we get a 'hello'?", {
  expect_equal(hello(), "Hello, world!")
})
