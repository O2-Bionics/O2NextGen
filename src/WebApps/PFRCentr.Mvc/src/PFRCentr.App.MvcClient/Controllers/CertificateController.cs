using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using PFRCentr.App.MvcClient.Models.Dto;
using PFRCentr.App.MvcClient.Services;

namespace PFRCentr.App.MvcClient.Controllers;

[Authorize]
public class CertificateController : Controller
{
    private readonly ICGenCertificateService _cGenCertificateService;

    public CertificateController(ICGenCertificateService cGenCertificateService)
    {
        _cGenCertificateService = cGenCertificateService;
    }

    public async Task<ViewResult> CertificateIndex()
    {
        var token = await HttpContext.GetTokenAsync("access_token");
        var response = await _cGenCertificateService.GetCertificatesAsync<List<CertificateDto>>(token);
        List<ResponseDto> list = null;
        // if (response != null && response.IsSuccess)
        // {
        //     list = JsonConvert.DeserializeObject<List<ResponseDto>>(response.ToString());
        // }
        return View(response);
    }

    public IActionResult CreateCertificate()
    {
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> CreateCertificate(CertificateDto model)
    {
        if (ModelState.IsValid)
        {
            var token = await HttpContext.GetTokenAsync("access_token");
            var response = await _cGenCertificateService.CreateCertificateAsync<CertificateDto>(model, token);
            List<ResponseDto> list = null;
            // if (response != null && response.IsSuccess)
            // {
            //     list = JsonConvert.DeserializeObject<List<ResponseDto>>(response.ToString());
            // }
            // if (response == null)
            //     return View(model);
            return RedirectToAction(nameof(CertificateIndex));
        }

        return View(model);
    }

    public async Task<IActionResult> EditCertificate(long CertificateId)
    {
        var token = await HttpContext.GetTokenAsync("access_token");
        var response = await _cGenCertificateService.GetCertificateByIdAsync<CertificateDto>(CertificateId, token);
        List<ResponseDto> list = null;
        if (response != null)
            return View(response);
        return NotFound();
        // {
        //     list = JsonConvert.DeserializeObject<List<ResponseDto>>(response.ToString());
        // }
        // if (response == null)
        //     return View(model);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> EditCertificate(CertificateDto model)
    {
        if (ModelState.IsValid)
        {
            var token = await HttpContext.GetTokenAsync("access_token");
            var response = await _cGenCertificateService.UpdateCertificateAsync<CertificateDto>(model.Id, model,token);
            List<ResponseDto> list = null;
            // if (response != null && response.IsSuccess)
            // {
            //     list = JsonConvert.DeserializeObject<List<ResponseDto>>(response.ToString());
            // }
            // if (response == null)
            //     return View(model);
            return RedirectToAction(nameof(CertificateIndex));
        }

        return View(model);
    }

    public async Task<IActionResult> DeleteCertificate(long CertificateId)
    {
        var token = await HttpContext.GetTokenAsync("access_token");
        var response = await _cGenCertificateService.GetCertificateByIdAsync<CertificateDto>(CertificateId, token);
        List<ResponseDto> list = null;
        if (response != null)
            return View(response);
        return NotFound();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteCertificate(CertificateDto model)
    {
        var token = await HttpContext.GetTokenAsync("access_token");
        await _cGenCertificateService.DeleteCertificateAsync<CertificateDto>(model.Id, token);
        return RedirectToAction(nameof(CertificateIndex));
    }
}