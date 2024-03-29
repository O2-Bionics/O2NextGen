namespace O2NextGen.CertificateManagement.Domain.UseCases.ForCategory.UpdateCategory;

public class UpdateCategoryDetailsCommandResult
{
    public long Id { get; }
    public long ModifiedDate { get; }
    public long AddedDate { get; }
    public long? DeletedDate { get; }
    public bool? IsDeleted { get; }
    public string CustomerId { get; }
    public string CategoryName { get; }
    public string CategoryDescription { get; }
    public int QuantityCertificates { get; }
    public int QuantityPublishCode { get; }

    public UpdateCategoryDetailsCommandResult(long id,
        long modifiedDate,
        long addedDate,
        long? deletedDate,
        bool? isDeleted, string customerId, string categoryName,
        string categoryDescription,
        int quantityCertificates, int quantityPublishCode)
    {
        Id = id;
        ModifiedDate = modifiedDate;
        AddedDate = addedDate;
        DeletedDate = deletedDate;
        IsDeleted = isDeleted;
        CustomerId = customerId;
        CategoryName = categoryName;
        CategoryDescription = categoryDescription;
        QuantityCertificates = quantityCertificates;
        QuantityPublishCode = quantityPublishCode;
    }
}