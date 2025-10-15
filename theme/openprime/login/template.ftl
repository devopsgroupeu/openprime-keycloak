<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html lang="en" class="${properties.kcHtmlClass!}">

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>

    <title><#nested "title"></title>

    <link rel="icon" href="${url.resourcesPath}/img/symbol.svg" type="image/svg+xml">
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" type="image/x-icon">

    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
</head>

<body class="login-pf ${bodyClass}">
    <div class="login-pf-page">
        <div id="kc-container" class="${properties.kcContainerClass!}">
            <div id="kc-container-wrapper" class="${properties.kcContainerWrapperClass!}">

                <div id="kc-header" class="${properties.kcHeaderClass!}">
                    <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}">
                        <#nested "header">
                    </div>
                </div>

                <div id="kc-content" class="${properties.kcContentClass!}">
                    <div id="kc-content-wrapper" class="${properties.kcContentWrapperClass!}">

                        <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                        <#-- during login.                                                                               -->
                        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                            <div class="alert alert-${message.type}">
                                <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                            </div>
                        </#if>

                        <#nested "form">

                        <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                            <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                                <div class="${properties.kcFormGroupClass!}">
                                    <input type="hidden" name="tryAnotherWay" value="on"/>
                                    <a href="#" id="try-another-way"
                                       onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                                </div>
                            </form>
                        </#if>

                        <#if displayInfo>
                            <div id="kc-info" class="${properties.kcSignUpClass!}">
                                <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                                    <#nested "info">
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Simple, reliable enhancements
        (function() {
            'use strict';

            // Replace "Terms and conditions to be defined" with actual terms
            const termsTextElement = document.querySelector('#kc-terms-text');
            if (termsTextElement) {
                const termsContent = `
                    <h2>Terms and Conditions</h2>
                    
                    <div>
                        <h3>1. Acceptance of Terms</h3>
                        <p>By accessing and using the OpenPrime platform, you agree to be bound by these Terms and Conditions. If you do not agree to these terms, please do not use our services.</p>
                        
                        <h3>2. User Account and Registration</h3>
                        <p>You must provide accurate, current, and complete information during the registration process. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.</p>
                        
                        <h3>3. Use of Services</h3>
                        <p>You agree to use our services only for lawful purposes and in accordance with these Terms. You must not:</p>
                        <ul>
                            <li>Use the services in any way that violates any applicable laws or regulations</li>
                            <li>Attempt to gain unauthorized access to any portion of the services</li>
                            <li>Interfere with or disrupt the services or servers</li>
                            <li>Transmit any viruses, malware, or other malicious code</li>
                        </ul>
                        
                        <h3>4. Privacy and Data Protection</h3>
                        <p>Your privacy is important to us. Our Privacy Policy explains how we collect, use, and protect your personal information. By using our services, you consent to our data practices as described in the Privacy Policy.</p>
                        
                        <h3>5. Intellectual Property</h3>
                        <p>All content, features, and functionality of the OpenPrime platform are owned by OpenPrime and are protected by international copyright, trademark, and other intellectual property laws.</p>
                        
                        <h3>6. Limitation of Liability</h3>
                        <p>OpenPrime shall not be liable for any indirect, incidental, special, consequential, or punitive damages resulting from your use or inability to use the services.</p>
                        
                        <h3>7. Changes to Terms</h3>
                        <p>We reserve the right to modify these Terms at any time. We will notify users of any material changes. Your continued use of the services after such changes constitutes acceptance of the modified Terms.</p>
                    </div>
                `;
                
                termsTextElement.innerHTML = termsContent;
            }

            // Style standalone asterisks to be red
            const textNodes = document.evaluate(
                "//text()[normalize-space(.)='*' and not(parent::span[@class='required'])]",
                document,
                null,
                XPathResult.ORDERED_NODE_SNAPSHOT_TYPE,
                null
            );

            for (let i = 0; i < textNodes.snapshotLength; i++) {
                const node = textNodes.snapshotItem(i);
                if (node.nodeValue.trim() === '*') {
                    const span = document.createElement('span');
                    span.className = 'required';
                    span.textContent = '*';
                    node.parentNode.replaceChild(span, node);
                }
            }

            // Focus first input for accessibility
            const firstInput = document.querySelector('input:not([type="hidden"]):not([disabled]):not([type="checkbox"])');
            if (firstInput) {
                firstInput.focus();
            }

            // Simple form validation feedback
            const inputs = document.querySelectorAll('input[required]');
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    if (this.type === 'checkbox') return;
                    if (this.value.trim() === '') {
                        this.style.borderColor = 'var(--op-error)';
                    } else {
                        this.style.borderColor = 'var(--op-success)';
                    }
                });

                input.addEventListener('input', function() {
                    if (this.type !== 'checkbox') {
                        this.style.borderColor = 'var(--op-primary)';
                    }
                });
            });

            // Loading state for submit button
            const form = document.querySelector('#kc-form-login, #kc-register-form, form[action*="registration"]');
            const submitBtn = document.querySelector('input[type="submit"], button[type="submit"]');
            if (submitBtn && form) {
                form.addEventListener('submit', function(e) {
                    submitBtn.disabled = true;
                    submitBtn.style.opacity = '0.6';
                });
            }

        })();
    </script>
</body>
</html>
</#macro>