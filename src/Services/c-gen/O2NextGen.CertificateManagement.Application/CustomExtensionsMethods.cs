using O2NextGen.CertificateManagement.Application.Services;
using O2NextGen.CertificateManagement.Application.Services.Interfaces;

namespace O2NextGen.CertificateManagement.Application;

internal static class CustomExtensionsMethods
{
    public static IServiceCollection AddCustomIntegrations(this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
        services.AddTransient<IIdentityService, IdentityService>();
        services.AddTransient<ICustomerService, CustomerService>();
        if (configuration["isTests"] == bool.FalseString.ToLowerInvariant())
            services.AddHttpClient<IQrCodeService, QrCodeService>();


        services.AddHttpClient<ITemplateService, TemplateService>();
        services.AddHttpClient<ISubscribeService, SubscribeService>();
        return services;
    }
}