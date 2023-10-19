## GitHub - Cloud Build Gen 2
### How to use this example
1. Review the [documentation](https://cloud.google.com/build/docs/automating-builds/github/connect-repo-github?generation=2nd-gen)
2. Install the Cloud Build GitHub app in the GitHub Organization and take note of the Installation ID
3. Create a personal access token with the required access. Note, you may have more than one host set up for GitHub (even sharing one app installation) if you prefer to have tighter scoping for your access token.
4. Instantiate the module with `create_connection` set to `false`
5. Add the access token to the oauth secret created
6. Change `create_connection` value to `true`