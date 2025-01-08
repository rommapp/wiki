# OIDC Setup With Authentik or Authelia

## A quick rundown of the technologies

### What is Authentik/Authelia?
Authentik and Authelia are an open-source identity provider (IdP) designed to manage authentication, authorization, and user management across applications. It supports modern authentication protocols and provides tools to simplify integration, including single sign-on (SSO), multi-factor authentication (MFA), and auditing capabilities. Authentik and Authelia can be deployed alongside your other services to centralize identity management.

Authentik and Authelia are diffrerent implementations of the same concept. **You only need one of these, not both.** 

### What is OAuth2?
OAuth2 (Open Authorization 2.0) is an industry-standard protocol for authorization. It allows applications (clients) to gain limited access to user accounts on an HTTP service without sharing the user’s credentials. Instead, it uses access tokens to facilitate secure interactions. OAuth2 is commonly used in scenarios where users need to authenticate via a third-party service.

### What is OpenID Connect (OIDC)?
OIDC (OpenID Connect) is an identity layer built on top of OAuth2. While OAuth2 primarily handles authorization, OIDC adds authentication, enabling applications to verify a user’s identity and obtain profile information. This makes OIDC suitable for SSO solutions, where user identity is central to access management.

## Setting up OIDC

### Step 1 with Authentik

#### Step 1a: Install and Configure Authentik
Before setting up a provider and app, ensure that Authentik is installed and running by following the [official installation guide.](https://docs.goauthentik.io/docs/install-config/install/docker-compose).

1. Access Authentik via its web interface.
2. Log in as an administrator.
3. Navigate to the “Admin Interface” to configure the necessary components.

![Authentik user dashboard](https://raw.githubusercontent.com/rommapp/wiki/refs/heads/main/romm.wiki/resources/authentik/1-user-dashboard.png)

#### Step 1b: Create a Provider
A provider in Authentik acts as the bridge between RomM and Authentik.

1. **Navigate to Providers**:
   - Go to the "Providers" section in the Authentik admin interface.
2. **Create a New Provider**:
   - Click on “Create” and choose the protocol (e.g., “OIDC Provider”).
![Create a new provider](https://raw.githubusercontent.com/rommapp/wiki/refs/heads/main/romm.wiki/resources/authentik/2-create-provider.png)
3. **Select "OAuth2/OpenID Provider"**
![Select OAuth2 provider](https://raw.githubusercontent.com/rommapp/wiki/refs/heads/main/romm.wiki/resources/authentik/3-new-provider.png)
4. **Configure Provider Settings**:
   - **Name**: Assign a unique name to the provider (e.g., "RomM OIDC Provider").
   - **Authorization flow**: Select __implicit consent__.
   - **Redirect URIs**: Add your RomM instance's URL + `/api/oauth/openid`  (e.g., `http://romm.host.local/api/oauth/openid`).
5. **Copy the Client ID and Secret**:
   - You'll need these to set `OIDC_CLIENT_ID` and `OIDC_CLIENT_SECRET` in your RomM instance.
![Provider settings](https://raw.githubusercontent.com/rommapp/wiki/refs/heads/main/romm.wiki/resources/authentik/4-provider-secrets.png)
6. **Click Create**.

#### Step 1c: Register an Application
An app in Authentik represents the external service (in our case RomM) that will use the provider for authentication.

1. **Navigate to Applications**:
   - Go to the "Applications" section in the admin interface.
![Applications](https://raw.githubusercontent.com/rommapp/wiki/refs/heads/main/romm.wiki/resources/authentik/5-applications.png)
2. **Create a New Application**:
   - Click on “Create” and configure the app settings:
     - **Name**: Provide a recognizable name (e.g., "RomM").
     - **Slug**: Create a unique identifier for the app (e.g., "romm").
     - **Provider**: Link the app to the previously created provider, "RomM OIDC Provider".
![New application](https://raw.githubusercontent.com/rommapp/wiki/refs/heads/main/romm.wiki/resources/authentik/6-new-application.png)
6. **Click Create**.

### Step 1 with Authelia

#### Step 1a: Prerequisites
We assume you have Authelia installed, configured and added an OpenID Connect Provider. If not, refer to the Authelia docs,
especially [Get started](https://www.authelia.com/integration/prologue/get-started/) and [OpenID Connect 1.0 Provider](https://www.authelia.com/configuration/identity-providers/openid-connect/provider/)

#### Step 1b: Add a client
In Authelia's `configuration.yml`, under `identity_providers` → `oidc` → `clients`, add a new entry:
* A – preferably random – `client_id` and `client_secret`, see the [official recommendations](https://www.authelia.com/integration/openid-connect/frequently-asked-questions/#how-do-i-generate-a-client-identifier-or-client-secret) for how to generate them.
* `public` should be set to `false`.
* `redirect_uris` should include your RomM instance's URL + `/api/oauth/openid`  (e.g., `http://romm.host.local/api/oauth/openid`).
* `scopes` includes `openid`, `email` and `profile`.
* `token_endpoint_auth_method` should be set to `client_secret_basic`.
* `userinfo_signed_response_alg` should be set to `none`.

Refer to the [official docs](https://www.authelia.com/configuration/identity-providers/openid-connect/clients/) for available options.

This entry could look like this:
```yaml
#identity_providers:
#  oidc:
#    clients:
      - client_id: "<randomly_generated>"  # read above for how generate
        client_name: "RomM" # will be displayed in Authelia to users
        client_secret: "$pbkdf2-sha512$randomly_generated" # read above for how generate
        public: false
        authorization_policy: "two_factor" # or one_factor, depending on your needs
        grant_types:
          - authorization_code
        redirect_uris:
          - "http://romm.host.local/api/oauth/openid"
        scopes:
          - "openid"
          - "email"
          - "profile"
        userinfo_signed_response_alg: "none"
        token_endpoint_auth_method: "client_secret_basic"
```


### Step 2: Configure RomM Environment Variables
To enable OIDC authentication in RomM, you need to set the following environment variables:

- `OIDC_ENABLED`: Set to `true` to enable OIDC authentication.
- `OIDC_PROVIDER`: The lowercase name of the provider (e.g., `authentik`, `authelia`).
- `OIDC_CLIENT_ID`: The client ID, either copied from the Authentik application or the Authelia configuration.
- `OIDC_CLIENT_SECRET`: The client secret 
  - **Authentik**: Copied form the Application.
  - **Authelia**: What you generated (not the digest, but what was output as `Random Password`).
- `OIDC_REDIRECT_URI`: The redirect URI that you configured, e.g. `http://romm.host.local/api/oauth/openid`.
- `OIDC_SERVER_APPLICATION_URL`: 
  - **Authentik**: The URL of the application, e.g., `http://authentik.host.local/application/o/romm`.
  - **Authelia**: The base URL for you Authelia instance, e.g. `http://authelia.host.local`.

### Step 3: Set your Email in RomM
In RomM, open your user profile and set your email address. This email **has to match** your user email in Authentik.

![Set email](https://raw.githubusercontent.com/rommapp/wiki/refs/heads/main/romm.wiki/resources/authentik/7-user-profile.png)

### Step 4: Test the Integration
After configuring the environment variables, restart (or stop and remove) your RomM instance and navigate to the login page. You should see an option to log in using OIDC. Click on the OIDC button, and you'll be redirected to Authentik for authentication. Once authenticated, you'll be redirected back to RomM.

![Login with OIDC](https://raw.githubusercontent.com/rommapp/wiki/refs/heads/main/romm.wiki/resources/authentik/8-romm-login.png)
