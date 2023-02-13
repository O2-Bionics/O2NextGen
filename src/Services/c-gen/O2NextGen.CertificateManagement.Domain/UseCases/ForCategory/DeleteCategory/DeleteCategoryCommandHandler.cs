using MediatR;
using O2NextGen.CertificateManagement.Domain.Data;
using O2NextGen.CertificateManagement.Domain.Data.Queries;
using O2NextGen.CertificateManagement.Domain.Entities;

namespace O2NextGen.CertificateManagement.Domain.UseCases.ForCategory.DeleteCategory;

public class DeleteCategoryCommandHandler : IRequestHandler<DeleteCategoryCommand, Unit>
{
    private readonly IQueryHandler<CategoryQuery, Category> _userGroupQueryHandler;
    private readonly IRepository<Category> groupsRepository;

    public DeleteCategoryCommandHandler(
        IQueryHandler<CategoryQuery, Category> userGroupQueryHandler,
        IRepository<Category> groupsRepository)
    {
        _userGroupQueryHandler =
            userGroupQueryHandler ?? throw new ArgumentNullException(nameof(userGroupQueryHandler));
        this.groupsRepository = groupsRepository;
    }

    public async Task<Unit> Handle(DeleteCategoryCommand request, CancellationToken cancellationToken)
    {
        var category = await _userGroupQueryHandler.HandleAsync(
            new CategoryQuery(request.Id),
            cancellationToken);

        if (category is object) await groupsRepository.DeleteAsync(category, cancellationToken);

        return Unit.Value;
    }
}