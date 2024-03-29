﻿using MediatR;
using Microsoft.AspNetCore.Mvc;
using O2NextGen.CertificateManagement.Domain.UseCases.ForCertificate.CreateCertificate;
using O2NextGen.CertificateManagement.Domain.UseCases.ForCertificate.DeleteCertificate;
using O2NextGen.CertificateManagement.Domain.UseCases.ForCertificate.GetCertificate;
using O2NextGen.CertificateManagement.Domain.UseCases.ForCertificate.GetCertificates;
using O2NextGen.CertificateManagement.Domain.UseCases.ForCertificate.UpdateCertificate;

namespace O2NextGen.CertificateManagement.Application.Features.Certificates
{
    [Route("api/[controller]")]
    [ApiController]
    public partial class CertificatesController : ControllerBase
    {
        #region Fields

        private readonly IMediator _mediator;
        private readonly ILogger<CertificatesController> _logger;

        private static readonly string GetByIdActionName
            = nameof(GetByIdAsync).Replace("Async", string.Empty);
        #endregion


        #region Ctors

        public CertificatesController(IMediator mediator, ILogger<CertificatesController> logger)
        {
            _mediator = mediator;
            _logger = logger;
        }

        #endregion


        #region Methods

        [HttpGet]
        [Route("{id}")]
        public async Task<IActionResult> GetByIdAsync(long id, CancellationToken ct)
        {
            var result = await _mediator.Send(new GetCertificateQuery(id), ct);

            if (result is null)
                return NotFound();

            return Ok(result);
        }

        [HttpGet]
        [Route("")]
        public async Task<IActionResult> GetAllAsync()
        {
            var result = await _mediator.Send(new GetCertificatesQuery());
            return Ok(result.Certificates);
        }

        [HttpPut]
        [Route("id")]
        public async Task<ActionResult<UpdateCertificateDetailsCommandResult>> UpdateAsync(
            long id, [FromBody] UpdateCertificateDetailsCommandModel model, CancellationToken ct)
        {
            var result = await _mediator.Send(
                new UpdateCertificateDetailsCommand(
                    id,
                    model.ExternalId,
                    model.ModifiedDate,
                    model.AddedDate,
                    model.DeletedDate,
                    model.IsDeleted,
                    model.OwnerAccountId,
                    model.CustomerId,
                    model.ExpiredDate,
                    model.PublishDate,
                    model.CreatorId,
                    model.PublishCode,
                    model.IsVisible,
                    model.CategoryId,
                    model.Category,
                    model.Lock,
                    model.LockedDate,
                    model.LockInfo,
                    model.LanguageInfos));

            if (result is null)
            {
                return NotFound();
            }

            return result;
        }

        [HttpPut]
        [HttpPost]
        [Route("")]
        public async Task<ActionResult<CreateCertificateCommandResult>> AddAsync(
            [FromBody] CreateCertificateDetailsCommandModel model,
            CancellationToken ct)
        {
            var result = await _mediator.Send(
                new CreateCertificateCommand(
                    model.ExternalId,
                    model.IsDeleted,
                    model.OwnerAccountId,
                    model.CustomerId,
                    model.ExpiredDate,
                    model.PublishDate,
                    model.CreatorId,
                    model.PublishCode,
                    model.IsVisible,
                    model.CategoryId,
                    model.Category,
                    model.Lock,
                    model.LockedDate,
                    model.LockInfo,
                    model.LanguageInfos
                ));
            return CreatedAtAction(GetByIdActionName,
                new { id = result.Id }, result);
        }

        [HttpDelete]
        [Route("{id}")]
        public async Task<IActionResult> RemoveAsync(long id, CancellationToken ct)
        {
            await _mediator.Send(new DeleteCertificateCommand(id));
            return NoContent();
        }

        #endregion
    }
}
