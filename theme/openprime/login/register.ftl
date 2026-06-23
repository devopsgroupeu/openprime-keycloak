<#import "template.ftl" as layout>
<#import "user-profile-commons.ftl" as userProfileCommons>
<#import "register-commons.ftl" as registerCommons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=true; section>
    <#if section = "header">
        <#if messageHeader??>
            ${kcSanitize(msg("${messageHeader}"))?no_esc}
        <#else>
            ${msg("registerTitle")}
        </#if>
    <#elseif section = "form">

        <#-- ===== Social / Identity Providers ===== -->
        <#if social.providers?has_content>
            <div id="kc-social-providers">
                <p class="social-heading">Sign up with</p>
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
            <p class="social-heading" style="margin-bottom: 4px;">Sign up with email</p>
        </#if>

        <#-- ===== Registration Form ===== -->
        <form id="kc-register-form" class="${properties.kcFormClass!}" action="${url.registrationAction}" method="post">

            <@userProfileCommons.userProfileFormFields; callback, attribute>
                <#if callback = "afterField">
                <#-- render password fields just under the username or email (if used as username) -->
                    <#if passwordRequired?? && (attribute.name == 'username' || (attribute.name == 'email' && realm.registrationEmailAsUsername))>
                        <div class="${properties.kcFormGroupClass!}">
                            <div class="${properties.kcLabelWrapperClass!}">
                                <label for="password" class="${properties.kcLabelClass!}">${msg("password")}</label> *
                            </div>
                            <div class="${properties.kcInputWrapperClass!}">
                                <div class="password-wrapper">
                                    <input type="password" id="password" class="${properties.kcInputClass!}" name="password"
                                           autocomplete="new-password"
                                           placeholder="Create a password"
                                           aria-invalid="<#if messagesPerField.existsError('password','password-confirm')>true</#if>"
                                    />
                                    <button class="password-toggle-btn" type="button" tabindex="-1"
                                            aria-label="Show password"
                                            onclick="var p=document.getElementById('password');var i=this.querySelector('i');if(p.type==='password'){p.type='text';i.className='fa fa-eye';}else{p.type='password';i.className='fa fa-eye-slash';}">
                                        <i class="fa fa-eye-slash" aria-hidden="true"></i>
                                    </button>
                                </div>

                                <#if messagesPerField.existsError('password')>
                                    <span id="input-error-password" class="input-error-msg" aria-live="polite">
                                        ${kcSanitize(messagesPerField.get('password'))?no_esc}
                                    </span>
                                </#if>
                            </div>
                        </div>

                        <div class="${properties.kcFormGroupClass!}">
                            <div class="${properties.kcLabelWrapperClass!}">
                                <label for="password-confirm" class="${properties.kcLabelClass!}">${msg("passwordConfirm")}</label> *
                            </div>
                            <div class="${properties.kcInputWrapperClass!}">
                                <div class="password-wrapper">
                                    <input type="password" id="password-confirm" class="${properties.kcInputClass!}"
                                           name="password-confirm" autocomplete="new-password"
                                           placeholder="Confirm your password"
                                           aria-invalid="<#if messagesPerField.existsError('password-confirm')>true</#if>"
                                    />
                                    <button class="password-toggle-btn" type="button" tabindex="-1"
                                            aria-label="Show password"
                                            onclick="var p=document.getElementById('password-confirm');var i=this.querySelector('i');if(p.type==='password'){p.type='text';i.className='fa fa-eye';}else{p.type='password';i.className='fa fa-eye-slash';}">
                                        <i class="fa fa-eye-slash" aria-hidden="true"></i>
                                    </button>
                                </div>

                                <#if messagesPerField.existsError('password-confirm')>
                                    <span id="input-error-password-confirm" class="input-error-msg" aria-live="polite">
                                        ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                                    </span>
                                </#if>
                            </div>
                        </div>
                    </#if>
                </#if>
            </@userProfileCommons.userProfileFormFields>

            <@registerCommons.termsAcceptance/>

            <#if recaptchaRequired?? && (recaptchaVisible!false)>
                <div class="form-group">
                    <div class="${properties.kcInputWrapperClass!}">
                        <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}" data-action="${recaptchaAction}"></div>
                    </div>
                </div>
            </#if>

            <div class="${properties.kcFormGroupClass!}">
                <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
                    <div class="${properties.kcFormOptionsWrapperClass!}">
                        <span><a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a></span>
                    </div>
                </div>

                <#if recaptchaRequired?? && !(recaptchaVisible!false)>
                    <script>
                        function onSubmitRecaptcha(token) {
                            document.getElementById("kc-register-form").requestSubmit();
                        }
                    </script>
                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                        <button class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} g-recaptcha"
                                data-sitekey="${recaptchaSiteKey}" data-callback='onSubmitRecaptcha' data-action='${recaptchaAction}' type="submit">
                            ${msg("doRegister")}
                        </button>
                    </div>
                <#else>
                    <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
                        <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}" type="submit" value="${msg("doRegister")}"/>
                    </div>
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
