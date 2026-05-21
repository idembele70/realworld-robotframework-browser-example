*** Variables ***
# LOCAL
${FRONT_BASE_URL}           %{FRONT_BASE_URL=http://localhost:8444/angular-conduit/}
${API_BASE_URL}             %{API_BASE_URL=http://localhost:3000/angular-conduit-api/api}

# PRODUCTION
# ${FRONT_BASE_URL}    %{FRONT_BASE_URL=https://demo.realworld.show/}
# ${API_BASE_URL}    %{API_BASE_URL=https://api.realworld.show/api}
# Forced to ignore https errors & disable verification on work machine due to ZScaler
${IGNORE_HTTPS_ERRORS}      %{IGNORE_HTTPS_ERRORS=True}
${VERIFY}                   %{VERIFY=False}

# MULTI ENV
${HEADLESS}                 %{HEADLESS=True}
${BROWSER}                  %{BROWSER=chromium}
${TIMEOUT}                  %{TIMEOUT=30s}
