import { HttpInterceptorFn } from '@angular/common/http';

export const apiInterceptor: HttpInterceptorFn = (req, next) => {
  const apiReq = req.clone({ url: `https://vps-dc56a7e6.vps.ovh.net/angular-conduit-api/api${req.url}` });
  return next(apiReq);
};
