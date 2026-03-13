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

    <!-- FontAwesome for password toggle eye icon -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA==" crossorigin="anonymous" referrerpolicy="no-referrer" />

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
        <!-- Animated decorative lines spanning full page -->
        <div class="deco-lines">
            <svg viewBox="0 0 1400 800" fill="none" xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="none">
                <path class="deco-line deco-line-1" d="M-80 750 C120 680, 280 520, 380 380 S560 180, 720 140 S920 120, 1050 180" stroke="url(#grad1)" stroke-width="1.5"/>
                <path class="deco-line deco-line-2" d="M-50 720 C140 650, 300 500, 400 360 S580 160, 740 130 S940 110, 1070 160" stroke="url(#grad2)" stroke-width="1"/>
                <path class="deco-line deco-line-3" d="M-100 700 C100 640, 260 490, 360 350 S540 160, 700 120 S900 100, 1030 150" stroke="url(#grad3)" stroke-width="1"/>
                <path class="deco-line deco-line-4" d="M-30 760 C160 690, 320 530, 420 400 S600 200, 760 160 S960 140, 1080 200" stroke="url(#grad4)" stroke-width="0.8"/>
                <path class="deco-line deco-line-5" d="M-120 680 C80 620, 240 470, 340 330 S520 140, 680 100 S880 90, 1010 130" stroke="url(#grad5)" stroke-width="0.8"/>
                <!-- Glowing dots along the curves -->
                <circle class="deco-dot deco-dot-1" cx="380" cy="370" r="4" fill="#2dd4bf"/>
                <circle class="deco-dot deco-dot-2" cx="720" cy="135" r="3" fill="#2dd4bf"/>
                <circle class="deco-dot deco-dot-3" cx="550" cy="175" r="3" fill="#14b8a6"/>
                <defs>
                    <linearGradient id="grad1" x1="0%" y1="50%" x2="100%" y2="50%">
                        <stop offset="0%" stop-color="rgba(45,212,191,0.03)"/>
                        <stop offset="25%" stop-color="rgba(45,212,191,0.28)"/>
                        <stop offset="55%" stop-color="rgba(45,212,191,0.18)"/>
                        <stop offset="80%" stop-color="rgba(45,212,191,0.08)"/>
                        <stop offset="100%" stop-color="rgba(45,212,191,0.0)"/>
                    </linearGradient>
                    <linearGradient id="grad2" x1="0%" y1="50%" x2="100%" y2="50%">
                        <stop offset="0%" stop-color="rgba(56,189,248,0.02)"/>
                        <stop offset="30%" stop-color="rgba(56,189,248,0.14)"/>
                        <stop offset="60%" stop-color="rgba(56,189,248,0.08)"/>
                        <stop offset="100%" stop-color="rgba(56,189,248,0.0)"/>
                    </linearGradient>
                    <linearGradient id="grad3" x1="0%" y1="50%" x2="100%" y2="50%">
                        <stop offset="0%" stop-color="rgba(45,212,191,0.01)"/>
                        <stop offset="30%" stop-color="rgba(45,212,191,0.22)"/>
                        <stop offset="55%" stop-color="rgba(45,212,191,0.12)"/>
                        <stop offset="85%" stop-color="rgba(45,212,191,0.04)"/>
                        <stop offset="100%" stop-color="rgba(45,212,191,0.0)"/>
                    </linearGradient>
                    <linearGradient id="grad4" x1="0%" y1="50%" x2="100%" y2="50%">
                        <stop offset="0%" stop-color="rgba(20,184,166,0.01)"/>
                        <stop offset="25%" stop-color="rgba(20,184,166,0.1)"/>
                        <stop offset="60%" stop-color="rgba(20,184,166,0.06)"/>
                        <stop offset="100%" stop-color="rgba(20,184,166,0.0)"/>
                    </linearGradient>
                    <linearGradient id="grad5" x1="0%" y1="50%" x2="100%" y2="50%">
                        <stop offset="0%" stop-color="rgba(45,212,191,0.01)"/>
                        <stop offset="25%" stop-color="rgba(45,212,191,0.15)"/>
                        <stop offset="55%" stop-color="rgba(45,212,191,0.08)"/>
                        <stop offset="100%" stop-color="rgba(45,212,191,0.0)"/>
                    </linearGradient>
                </defs>
            </svg>
        </div>

        <!-- ===== Left Branding Panel ===== -->
        <div class="split-left">

            <div class="split-left-content">
                <div class="brand-logo">
                    <img class="logo-dark" src="${url.resourcesPath}/img/logo-dark.svg" alt="OpenPrime" />
                    <img class="logo-light" src="${url.resourcesPath}/img/logo-light.svg" alt="OpenPrime" />
                </div>

                <h1 class="brand-headline">
                    Deploy Anywhere<br/>with <span class="brand-headline-accent">OpenPrime</span>
                </h1>

                <p class="brand-description">
                    Configure and deploy your infrastructure on-premise<br/>
                    or in AWS, Azure, GCP with a single unified platform.
                </p>

                <div class="feature-items">
                    <div class="feature-item">
                        <svg class="feature-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2L2 7l10 5 10-5-10-5z"/><path d="M2 17l10 5 10-5"/><path d="M2 12l10 5 10-5"/></svg>
                        <span>Multi-Cloud</span>
                    </div>
                    <div class="feature-item">
                        <svg class="feature-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M14.7 6.3a1 1 0 0 0 0 1.4l1.6 1.6a1 1 0 0 0 1.4 0l3.77-3.77a6 6 0 0 1-7.94 7.94l-6.91 6.91a2.12 2.12 0 0 1-3-3l6.91-6.91a6 6 0 0 1 7.94-7.94l-3.76 3.76z"/></svg>
                        <span>Helm Charts</span>
                    </div>
                    <div class="feature-item">
                        <svg class="feature-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><polyline points="16 18 22 12 16 6"/><polyline points="8 6 2 12 8 18"/></svg>
                        <span>IaC Export</span>
                    </div>
                    <div class="feature-item">
                        <svg class="feature-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
                        <span>Security First</span>
                    </div>
                    <div class="feature-item">
                        <svg class="feature-icon" xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"><circle cx="18" cy="18" r="3"/><circle cx="6" cy="6" r="3"/><path d="M6 21V9a9 9 0 0 0 9 9"/></svg>
                        <span>GitOps Ready</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== Right Form Panel ===== -->
        <div class="split-right">
            <div id="kc-container" class="${properties.kcContainerClass!}">
                <div id="kc-container-wrapper" class="${properties.kcContainerWrapperClass!}">

                    <div id="kc-content" class="${properties.kcContentClass!}">
                        <div id="kc-content-wrapper" class="${properties.kcContentWrapperClass!}">

                            <!-- Tab Navigation -->
                            <div class="auth-tabs">
                                <a href="${url.loginUrl}" class="auth-tab" data-tab="login">Log In</a>
                                <#if url.registrationUrl??>
                                    <a href="${url.registrationUrl}" class="auth-tab" data-tab="register">Sign Up</a>
                                </#if>
                            </div>

                            <!-- Page title + subtitle -->
                            <div id="kc-header" class="${properties.kcHeaderClass!}">
                                <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}">
                                    <#nested "header">
                                </div>
                            </div>

                            <#-- Alert messages -->
                            <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                                <div class="alert alert-${message.type}">
                                    <#if message.type = 'error'>
                                        <svg class="alert-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                                    <#elseif message.type = 'success'>
                                        <svg class="alert-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>
                                    <#elseif message.type = 'info'>
                                        <svg class="alert-icon" xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>
                                    </#if>
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

                            <div id="kc-footer">
                                <p class="kc-footer-legal">
                                    By continuing, you agree to our
                                    <a href="#" class="footer-link">Terms of Service</a>
                                    and
                                    <a href="#" class="footer-link">Privacy Policy</a>.
                                </p>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <script>
        (function() {
            'use strict';

            // Detect current page and update tab + subtitle accordingly
            var isRegister = document.body.classList.contains('register') ||
                             window.location.href.indexOf('registration') !== -1 ||
                             window.location.href.indexOf('register') !== -1;
            var isResetPassword = window.location.href.indexOf('reset-credentials') !== -1 ||
                                  window.location.href.indexOf('forgot') !== -1 ||
                                  document.querySelector('#kc-page-title') &&
                                  document.querySelector('#kc-page-title').textContent.trim() === 'Reset Password';

            // Set active tab based on detected page
            var authTabs = document.querySelectorAll('.auth-tab');
            authTabs.forEach(function(tab) {
                if (isRegister && tab.getAttribute('data-tab') === 'register') {
                    tab.classList.add('auth-tab-active');
                } else if (!isRegister && !isResetPassword && tab.getAttribute('data-tab') === 'login') {
                    tab.classList.add('auth-tab-active');
                }
            });

            // Page-specific header visibility
            // Login/Register: hide header (tabs already indicate the page)
            // Reset Password: show header + subtitle, hide tabs
            var header = document.getElementById('kc-header');
            var headerWrapper = document.getElementById('kc-header-wrapper');

            if (isResetPassword) {
                if (header) header.style.display = 'block';
                if (headerWrapper) {
                    var sub = document.createElement('p');
                    sub.className = 'auth-subtitle';
                    sub.textContent = 'Enter your email to receive a reset link';
                    headerWrapper.appendChild(sub);
                }
                var tabs = document.querySelector('.auth-tabs');
                if (tabs) tabs.style.display = 'none';
            } else {
                if (header) header.style.display = 'none';
            }

            // Register & Reset-password: move navigation link below submit button with separator
            if (isRegister || isResetPassword) {
                var formOpts = document.getElementById('kc-form-options');
                var kcFooter = document.getElementById('kc-footer');
                if (formOpts && kcFooter) {
                    var link = formOpts.querySelector('a[href]');
                    if (link) {
                        // Create nav section matching login card layout (border-top separator)
                        var navSection = document.createElement('div');
                        navSection.id = 'kc-nav-link';
                        navSection.className = 'kc-signup';
                        var span = document.createElement('span');
                        if (isRegister) {
                            span.appendChild(document.createTextNode('Already have an account? '));
                            span.appendChild(link);
                        } else {
                            link.textContent = 'Back to Log In';
                            span.appendChild(link);
                        }
                        navSection.appendChild(span);
                        kcFooter.parentNode.insertBefore(navSection, kcFooter);
                    }
                    formOpts.remove();
                }
                // Hide original #kc-info on reset-password (email instruction is redundant with subtitle)
                if (isResetPassword) {
                    var kcInfo = document.getElementById('kc-info');
                    if (kcInfo) kcInfo.style.display = 'none';
                }
            }

            // Replace "Terms and conditions to be defined" with actual terms
            var termsTextElement = document.querySelector('#kc-terms-text');
            if (termsTextElement) {
                termsTextElement.innerHTML = '<h2>Terms and Conditions</h2><div><h3>1. Acceptance of Terms</h3><p>By accessing and using the OpenPrime platform, you agree to be bound by these Terms and Conditions.</p><h3>2. User Account</h3><p>You must provide accurate information during registration. You are responsible for maintaining the confidentiality of your account credentials.</p><h3>3. Use of Services</h3><p>You agree to use our services only for lawful purposes and in accordance with these Terms.</p><h3>4. Privacy</h3><p>Your privacy is important to us. Our Privacy Policy explains how we collect, use, and protect your personal information.</p><h3>5. Intellectual Property</h3><p>All content and functionality of the OpenPrime platform are owned by OpenPrime and protected by intellectual property laws.</p><h3>6. Limitation of Liability</h3><p>OpenPrime shall not be liable for any indirect, incidental, or consequential damages resulting from your use of the services.</p><h3>7. Changes to Terms</h3><p>We reserve the right to modify these Terms at any time. Continued use constitutes acceptance of the modified Terms.</p></div>';
            }

            // Style standalone asterisks
            var textNodes = document.evaluate(
                "//text()[normalize-space(.)='*' and not(parent::span[@class='required'])]",
                document, null, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null
            );
            for (var i = 0; i < textNodes.snapshotLength; i++) {
                var node = textNodes.snapshotItem(i);
                if (node.nodeValue.trim() === '*') {
                    var span = document.createElement('span');
                    span.className = 'required';
                    span.textContent = '*';
                    node.parentNode.replaceChild(span, node);
                }
            }

            // Focus first input
            var firstInput = document.querySelector('input:not([type="hidden"]):not([disabled]):not([type="checkbox"])');
            if (firstInput) firstInput.focus();

            // Form validation feedback
            var inputs = document.querySelectorAll('input[required]');
            inputs.forEach(function(input) {
                input.addEventListener('blur', function() {
                    if (this.type === 'checkbox') return;
                    this.classList.toggle('input-error', this.value.trim() === '');
                    this.classList.toggle('input-success', this.value.trim() !== '');
                });
                input.addEventListener('input', function() {
                    if (this.type !== 'checkbox') {
                        this.classList.remove('input-error', 'input-success');
                    }
                });
            });

            // Loading state for submit button
            var form = document.querySelector('#kc-form-login, #kc-register-form, form[action*="registration"]');
            var submitBtn = document.querySelector('input[type="submit"], button[type="submit"]');
            if (submitBtn && form) {
                form.addEventListener('submit', function() {
                    submitBtn.disabled = true;
                    submitBtn.style.opacity = '0.7';
                    submitBtn.value = submitBtn.value || submitBtn.textContent;
                });
            }
        })();
    </script>
</body>
</html>
</#macro>
