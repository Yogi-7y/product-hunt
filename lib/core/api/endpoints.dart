const _kDomain = 'producthunt.com';
const _kSubDomain = 'api';
const _kProtocol = 'https';
const _kApiVersion = 'v1';

const _kHost = '$_kSubDomain.$_kDomain';

Uri _uri = Uri(
  scheme: _kProtocol,
  host: _kHost,
  path: _kApiVersion,
);

final kBasrUrl = _uri.toString();

const kTodaysPostsEndpoint = '/posts';
