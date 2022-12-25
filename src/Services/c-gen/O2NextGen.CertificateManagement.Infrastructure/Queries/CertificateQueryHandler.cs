﻿using System;
using O2NextGen.CertificateManagement.Domain.Data;
using System.Text.RegularExpressions;
using O2NextGen.CertificateManagement.Domain.Data.Queries;
using O2NextGen.CertificateManagement.Domain.Entities;
using O2NextGen.CertificateManagement.Infrastructure.Data;
using Microsoft.EntityFrameworkCore;

namespace O2NextGen.CertificateManagement.Infrastructure.Queries
{
    public class CertificateQueryHandler : IQueryHandler<CertificateQuery, CertificateDbEntity>
    {
        private readonly CertificateManagementDbContext context;

        public CertificateQueryHandler(CertificateManagementDbContext context)
        {
            this.context = context;
        }
        public async Task<CertificateDbEntity> HandleAsync(CertificateQuery query, CancellationToken ct)
        {
            var result = await context.Set<CertificateDbEntity>().FindAsync(new object[] { query.Id }, ct);
            return result;
        }
        
    }
}

