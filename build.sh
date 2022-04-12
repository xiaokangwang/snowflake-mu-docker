SNOWFLAKE_REPO=https://builder:@gitlab.torproject.org/shelikhoo/snowflake.git
SNOWFLAKE_REPO_ANCHOR=bd412f540cb85be8c913f8ec7cfd679240daebe5
docker build --progress plain --target broker --tag snowflake-broker --build-arg SNOWFLAKE_REPO=$SNOWFLAKE_REPO --build-arg SNOWFLAKE_REPO_ANCHOR=$SNOWFLAKE_REPO_ANCHOR .
docker build --progress plain --target proxy --tag snowflake-proxy --build-arg SNOWFLAKE_REPO=$SNOWFLAKE_REPO --build-arg SNOWFLAKE_REPO_ANCHOR=$SNOWFLAKE_REPO_ANCHOR .
docker build --progress plain --target client --tag snowflake-client --build-arg SNOWFLAKE_REPO=$SNOWFLAKE_REPO --build-arg SNOWFLAKE_REPO_ANCHOR=$SNOWFLAKE_REPO_ANCHOR .
docker build --progress plain --target server --tag snowflake-server --build-arg SNOWFLAKE_REPO=$SNOWFLAKE_REPO --build-arg SNOWFLAKE_REPO_ANCHOR=$SNOWFLAKE_REPO_ANCHOR .
