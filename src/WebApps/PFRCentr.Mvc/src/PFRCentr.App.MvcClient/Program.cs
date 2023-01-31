﻿using System.IdentityModel.Tokens.Jwt;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.OpenIdConnect;
using Microsoft.IdentityModel.Logging;

var builder = WebApplication.CreateBuilder(args);
IdentityModelEventSource.ShowPII = true;
// Add services to the container.
builder.Services.AddControllersWithViews();

JwtSecurityTokenHandler.DefaultInboundClaimTypeMap.Clear();
var identityUrl = Environment.GetEnvironmentVariable("Services:AuthApiUrl") ??
    builder.Configuration.GetValue<string>("Services:AuthApiUrl");//identity server 

Console.WriteLine($"IdentityUrl = {identityUrl}");

builder.Services.AddAuthentication(option =>
    {
        option.DefaultScheme = CookieAuthenticationDefaults.AuthenticationScheme;
        option.DefaultChallengeScheme = 
        OpenIdConnectDefaults.AuthenticationScheme;
    }).AddCookie(CookieAuthenticationDefaults.AuthenticationScheme,
        options =>
        {
            options.ExpireTimeSpan = TimeSpan.FromMinutes(10) ;
            // options.Cookie.Name = adminConfiguration.IdentityAdminCookieName;

            // options.Cookie.SameSite = SameSiteMode.None;
            // options.Cookie.HttpOnly = true;
            // options.Cookie.SecurePolicy = CookieSecurePolicy.Always;
            // options.Events = new CookieAuthenticationEvents
            // {
            //     OnSignedIn = context => OnSignedIn(context, adminConfiguration, httpContextAccessor),
            //     OnSigningIn = context => OnSigningIn(context, adminConfiguration, httpContextAccessor),
            //     OnValidatePrincipal = context => OnValidatePrincipal(context, adminConfiguration, httpContextAccessor)
            // };
        })
    .AddOpenIdConnect(OpenIdConnectDefaults.AuthenticationScheme, options =>
    {
        options.SignInScheme = CookieAuthenticationDefaults.AuthenticationScheme;
        options.Authority = identityUrl;
        options.GetClaimsFromUserInfoEndpoint  = true;
        options.RequireHttpsMetadata = true;
        options.ClientId = "mvc";
        options.ClientSecret = "secret"; 
        options.ResponseType = "code";
        options.TokenValidationParameters.NameClaimType = "name";
        options.TokenValidationParameters.RoleClaimType = "role";
        options.Scope.Add("cgen.api");
        options.SaveTokens = true;
    });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
  
}
// The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
app.UseHsts();
app.UseHttpsRedirection();
//fix https://github.com/IdentityServer/IdentityServer4/issues/4645
app.Use((context, next) => { context.Request.Scheme = "https"; return next(); });
app.UseHttpsRedirection();
app.UseStaticFiles();
//app.UseCookiePolicy();
app.UseRouting();

app.UseAuthentication();    
app.UseAuthorization();   

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
