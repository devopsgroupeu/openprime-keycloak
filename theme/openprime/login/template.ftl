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

            // Add GDPR checkbox to registration form dynamically
            const registerForm = document.querySelector('#kc-register-form, form[action*="registration"]');
            if (registerForm) {
                // Find the form buttons container
                const formButtons = registerForm.querySelector('#kc-form-buttons, .form-group:has(input[type="submit"]), .form-group:has(button[type="submit"])');
                
                if (formButtons) {
                    // Create GDPR form group to match other form fields structure
                    const gdprFormGroup = document.createElement('div');
                    gdprFormGroup.className = 'form-group';
                    
                    // Create wrapper div to match Bootstrap col structure
                    const colWrapper = document.createElement('div');
                    colWrapper.className = 'col-xs-12 col-sm-12 col-md-12 col-lg-12';
                    
                    // Create inner container with flex display
                    const gdprContainer = document.createElement('div');
                    gdprContainer.className = 'gdpr-checkbox-group';
                    gdprContainer.style.display = 'flex';
                    gdprContainer.style.alignItems = 'flex-start';
                    gdprContainer.style.gap = '12px';
                    
                    // Create checkbox
                    const checkbox = document.createElement('input');
                    checkbox.type = 'checkbox';
                    checkbox.id = 'gdpr-consent';
                    checkbox.name = 'gdprConsent';
                    checkbox.required = true;
                    
                    // Create label with styled spans instead of anchor tags
                    const label = document.createElement('label');
                    label.htmlFor = 'gdpr-consent';
                    label.innerHTML = 'I agree to the <span class="gdpr-link" data-url="https://openprime.com/terms">Terms of Service</span> and <span class="gdpr-link" data-url="https://openprime.com/privacy">Privacy Policy</span> <span style="color: var(--op-error);">*</span>';
                    
                    // Prevent label click from triggering checkbox
                    label.addEventListener('click', function(e) {
                        if (e.target.classList.contains('gdpr-link')) {
                            e.preventDefault();
                            e.stopPropagation();
                            window.open(e.target.getAttribute('data-url'), '_blank', 'noopener,noreferrer');
                        }
                    });
                    
                    // Build structure: formGroup > colWrapper > gdprContainer > (checkbox + label)
                    gdprContainer.appendChild(checkbox);
                    gdprContainer.appendChild(label);
                    colWrapper.appendChild(gdprContainer);
                    gdprFormGroup.appendChild(colWrapper);
                    
                    // Insert before the form buttons container
                    formButtons.parentNode.insertBefore(gdprFormGroup, formButtons);
                }
            }

            // Loading state for submit button with GDPR validation
            const form = document.querySelector('#kc-form-login, #kc-register-form, form[action*="registration"]');
            const submitBtn = document.querySelector('input[type="submit"], button[type="submit"]');
            if (submitBtn && form) {
                form.addEventListener('submit', function(e) {
                    // Check GDPR consent on registration form
                    const gdprCheckbox = document.querySelector('#gdpr-consent');
                    if (gdprCheckbox && !gdprCheckbox.checked) {
                        e.preventDefault();
                        alert('Please accept the Terms of Service and Privacy Policy to continue.');
                        return false;
                    }
                    
                    submitBtn.disabled = true;
                    submitBtn.style.opacity = '0.6';
                });
            }

        })();
    </script>
</body>
</html>
</#macro>