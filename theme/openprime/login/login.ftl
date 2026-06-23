<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
    <div id="kc-form">

        <#-- ===== Social / Identity Providers ===== -->
        <#if realm.password && social.providers?has_content>
            <div id="kc-social-providers">
                <p class="social-heading">Log in with</p>
                <ul class="social-grid">
                    <#list social.providers as p>
                        <li>
                            <a id="social-${p.alias}" class="social-btn" href="${p.loginUrl}">
                                <#if p.iconClasses?has_content>
                                    <i class="${p.iconClasses!}" aria-hidden="true"></i>
                                </#if>
                                <span>${p.displayName!}</span>
                            </a>
                        </li>
                    </#list>
                </ul>
            </div>
            <div class="auth-separator">
                <span>or continue with email</span>
            </div>
        <#else>
            <p class="social-heading" style="margin-bottom: 4px;">Log in with email</p>
        </#if>

        <#-- ===== Login Form ===== -->
        <div id="kc-form-wrapper">
            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">

                    <#if !usernameHidden??>
                        <div class="form-group">
                            <label for="username"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                            <input tabindex="2" id="username" name="username"
                                   value="${(login.username!'')}"
                                   type="text" autofocus autocomplete="username"
                                   placeholder="Your email address"
                                   aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />

                            <#if messagesPerField.existsError('username','password')>
                                <span class="input-error-msg" aria-live="polite">
                                    ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                                </span>
                            </#if>
                        </div>
                    </#if>

                    <div class="form-group">
                        <label for="password">${msg("password")}</label>
                        <div class="password-wrapper">
                            <input tabindex="3" id="password" name="password"
                                   type="password" autocomplete="current-password"
                                   placeholder="Your password"
                                   aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
                            <button class="password-toggle-btn" type="button" tabindex="-1"
                                    aria-label="Show password"
                                    onclick="var p=document.getElementById('password');var i=this.querySelector('i');if(p.type==='password'){p.type='text';i.className='fa fa-eye';}else{p.type='password';i.className='fa fa-eye-slash';}">
                                <i class="fa fa-eye-slash" aria-hidden="true"></i>
                            </button>
                        </div>
                    </div>

                    <div class="form-options-row">
                        <#if realm.rememberMe && !usernameHidden??>
                            <label class="remember-me-label">
                                <input tabindex="5" id="rememberMe" name="rememberMe" type="checkbox" <#if login.rememberMe??>checked</#if>>
                                <span>${msg("rememberMe")}</span>
                            </label>
                        </#if>
                        <#if realm.resetPasswordAllowed>
                            <a tabindex="6" class="forgot-link" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                        </#if>
                    </div>

                    <div id="kc-form-buttons" class="form-group">
                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <input tabindex="7" name="login" id="kc-login" type="submit" value="Continue"/>
                    </div>
                </form>
            </#if>
        </div>

    </div>
    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration">
                <span>${msg("noAccount")} <a tabindex="8" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
        </#if>
    </#if>
</@layout.registrationLayout>
