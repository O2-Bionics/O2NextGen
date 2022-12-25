﻿using System;
using MediatR;
using O2NextGen.CertificateManagement.Domain.Entities;

namespace O2NextGen.CertificateManagement.Domain.UseCases.Certificate.UpdateCertificate
{
    public class UpdateCertificateDetailsCommand: IRequest<UpdateCertificateDetailsCommandResult>
    {
        public UpdateCertificateDetailsCommand(
            long id,
            string externalId, bool? isDeleted, string ownerAccountId, string customerId,
            long expiredDate, long publishDate, string creatorId, string publishCode, bool isVisible,
            long categoryId, CategoryDbEntity category, bool @lock, long lockedDate, string lockInfo,
            ICollection<LanguageInfoDbEntity> languageInfos)
        {
            Id = id;
            ExternalId = externalId;
            IsDeleted = isDeleted;
            OwnerAccountId = ownerAccountId;
            CustomerId = customerId;
            ExpiredDate = expiredDate;
            PublishDate = publishDate;
            CreatorId = creatorId;
            PublishCode = publishCode;
            IsVisible = isVisible;
            CategoryId = categoryId;
            Category = category;
            Lock = @lock;
            LockedDate = lockedDate;
            LockInfo = lockInfo;
            LanguageInfos = languageInfos;
        }

        public UpdateCertificateDetailsCommand(long id, string externalId, bool? modifiedDate, string addedDate, string deletedDate, bool? isDeleted, string ownerAccountId, string customerId, long expiredDate, long publishDate, string creatorId, string publishCode, bool isVisible, long categoryId, CategoryDbEntity category, bool @lock, long lockedDate, string lockInfo, ICollection<LanguageInfoDbEntity> languageInfos)
        {
            Id = id;
            ExternalId = externalId;
            ModifiedDate = modifiedDate;
            AddedDate = addedDate;
            DeletedDate = deletedDate;
            IsDeleted = isDeleted;
            OwnerAccountId = ownerAccountId;
            CustomerId = customerId;
            ExpiredDate = expiredDate;
            PublishDate = publishDate;
            CreatorId = creatorId;
            PublishCode = publishCode;
            IsVisible = isVisible;
            CategoryId = categoryId;
            Category1 = category;
            Lock = @lock;
            LockedDate = lockedDate;
            LockInfo = lockInfo;
            LanguageInfos1 = languageInfos;
        }

        public long Id { get; }
        public string ExternalId { get; }
        public bool? IsDeleted { get; }
        public string OwnerAccountId { get; }
        public string CustomerId { get; }
        public long ExpiredDate { get; }
        public long PublishDate { get; }
        public string CreatorId { get; }
        public string PublishCode { get; }
        public bool IsVisible { get; }
        public long CategoryId { get; }
        public CategoryDbEntity Category { get; }
        public bool Lock { get; }
        public long LockedDate { get; }
        public string LockInfo { get; }
        public ICollection<LanguageInfoDbEntity> LanguageInfos { get; }
        public bool? ModifiedDate { get; }
        public string AddedDate { get; }
        public string DeletedDate { get; }
        public CategoryDbEntity Category1 { get; }
        public ICollection<LanguageInfoDbEntity> LanguageInfos1 { get; }
    }
}

