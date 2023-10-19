## GitLab - Cloud Build Gen 2
### How to use this example
1. Review the [documentation](https://cloud.google.com/build/docs/automating-builds/gitlab/connect-host-gitlab).
Note: If you are using GitLab Enterprise Edition there may be further requirements depending on your existing setup. [Read More](https://cloud.google.com/build/docs/automating-builds/gitlab/connect-host-gitlab-enterprise-edition).
2. Create the access tokens with enough access to read and write to the required repositories. Note, you may have more than one host set up for GitLab if you prefer to have tighter scoping for your access tokens.
3. Instantiate the module with `create_connection` set to `false`
4. Generate a UUID and store it in the webhook secret created.
5. Add the access tokens to the authorizer secrets created
6. Change `create_connection` value to `true`