﻿using O2NextGen.CertificateManagement.Domain.Data;
using O2NextGen.CertificateManagement.Domain.Data.Queries;
using O2NextGen.CertificateManagement.Domain.Entities;
using O2NextGen.CertificateManagement.Infrastructure.Data;

namespace O2NextGen.CertificateManagement.Infrastructure.Queries;

public class CertificateQueryHandler : IQueryHandler<CertificateQuery, CertificateEntity>
{
    private readonly CGenDbContext context;

    public CertificateQueryHandler(CGenDbContext context)
    {
        this.context = context;
    }

    public async Task<CertificateEntity> HandleAsync(CertificateQuery query, CancellationToken ct)
    {
        var result = await context.Set<CertificateEntity>().FindAsync(new object[] {query.Id}, ct);
        return result;
    }
}