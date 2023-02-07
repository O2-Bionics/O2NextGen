﻿using MediatR;
using Microsoft.AspNetCore.Mvc;
using O2NextGen.SmartSubscriber.Domain.UseCases.ForSubscription.CreateSubscription;
using O2NextGen.SmartSubscriber.Domain.UseCases.ForSubscription.DeleteSubscription;
using O2NextGen.SmartSubscriber.Domain.UseCases.ForSubscription.GetSubscription;
using O2NextGen.SmartSubscriber.Domain.UseCases.ForSubscription.GetSubscriptions;
using O2NextGen.SmartSubscriber.Domain.UseCases.ForSubscription.UpdateSubscription;

namespace O2NextGen.SmartSubscriber.Application.Features.Subscriptions;

[Route("api/[controller]")]
[ApiController]
public partial class SubscriptionsController : ControllerBase
{
    #region Fields

    private readonly IMediator _mediator;
    private readonly ILogger<SubscriptionsController> _logger;

    private static readonly string GetByIdActionName
        = nameof(GetByIdAsync).Replace("Async", string.Empty);

    #endregion


    #region Ctors

    public SubscriptionsController(IMediator mediator, ILogger<SubscriptionsController> logger)
    {
        _mediator = mediator;
        _logger = logger;
    }

    #endregion


    #region Methods

    [HttpGet]
    [Route("{id:long}")]
    public async Task<IActionResult> GetByIdAsync(long id, CancellationToken ct)
    {
        var result = await _mediator.Send(new GetSubscriptionQuery(id), ct);

        if (result is null)
            return NotFound();

        return Ok(result);
    }

    [HttpGet]
    [Route("")]
    public async Task<IActionResult> GetAllAsync()
    {
        var result = await _mediator.Send(new GetSubscriptionsQuery());
        return Ok(result.Subscriptions);
    }

    [HttpPut]
    [Route("{id:long}")]
    public async Task<ActionResult<UpdateSubscriptionDetailsCommandResult>> UpdateAsync(
        long id, [FromBody] UpdateSubscriptionDetailsCommandModel model, CancellationToken ct)
    {
        var result = await _mediator.Send(
            new UpdateSubscriptionDetailsCommand(
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
                model.ProductId,
                model.Product,
                model.Lock,
                model.LockedDate,
                model.LockInfo), ct);

        if (result is null)
        {
            return NotFound();
        }

        return result;
    }

    [HttpPut]
    [HttpPost]
    [Route("")]
    public async Task<ActionResult<CreateSubscriptionCommandResult>> AddAsync(
        [FromBody] CreateSubscriptionDetailsCommandModel model,
        CancellationToken ct)
    {
        var result = await _mediator.Send(
            new CreateSubscriptionCommand(
                model.ExternalId,
                model.IsDeleted,
                model.OwnerAccountId,
                model.CustomerId,
                model.ExpiredDate,
                model.PublishDate,
                model.CreatorId,
                model.PublishCode,
                model.IsVisible,
                model.ProductId,
                model.Product,
                model.Lock,
                model.LockedDate,
                model.LockInfo
            ), ct);
        return CreatedAtAction(GetByIdActionName,
            new {id = result.Id}, result);
    }

    [HttpDelete]
    [Route("{id:long}")]
    public async Task<IActionResult> RemoveAsync(long id, CancellationToken ct)
    {
        await _mediator.Send(new DeleteSubscriptionCommand(id), ct);
        return NoContent();
    }

    #endregion
}