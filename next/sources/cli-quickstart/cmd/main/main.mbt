///|
/// start main
async fn main {
  let argv = @env.args()
  let config = @app.parse_config(argv[1:])
  @app.run(config)
}
// end main
