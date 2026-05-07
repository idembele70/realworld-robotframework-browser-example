import { HttpInterceptorFn } from '@angular/common/http';

export const apiInterceptor: HttpInterceptorFn = (req, next) => {
  const apiReq = req.clone({ url: `http://localhost:3000/angular-conduit-api/api${req.url}` });
  return next(apiReq);
};
