# New ports collection makefile for:	php5-swfed
# Date created:		2010-06-13
# Whom:			TAKATSU Tomonari <tota@FreeBSD.org>
#
# $FreeBSD$
#

PORTNAME=	swfed
PORTVERSION=	0.28
CATEGORIES=	graphics www
MASTER_SITES=	SFJP
MASTER_SITE_SUBDIR=	${PORTNAME}/50400
PKGNAMEPREFIX=	php5-

MAINTAINER=	yoya@awm.jp
COMMENT=	A PHP extension to edit SWF file

BUILD_DEPENDS=	re2c:${PORTSDIR}/devel/re2c

DEFAULT_PHP_VER=	5
IGNORE_WITH_PHP=	4
USE_PHP=	zlib
USE_PHPEXT=	yes

WRKSRC=	${WRKDIR}/${DISTNAME}/src
CONFIGURE_ARGS=	--with-zlib-dir=yes

PORTDOCS=	readme.txt
PORTEXAMPLES=	*

PLIST_SUB=	WWWOWN=${WWWOWN} WWWGRP=${WWWGRP}

OPTIONS=	GIF	"With gif image support" on \
		PNG	"With png image support" on

.include <bsd.port.pre.mk>

.if defined(WITH_GIF)
LIB_DEPENDS+=	gif.5:${PORTSDIR}/graphics/giflib
CONFIGURE_ARGS+=	--with-gif-dir=yes
.else
CONFIGURE_ARGS+=	--with-gif-dir=no
.endif

.if defined(WITH_PNG)
LIB_DEPENDS+=	png.6:${PORTSDIR}/graphics/png
CONFIGURE_ARGS+=	--with-png-dir=yes
.else
CONFIGURE_ARGS+=	--with-png-dir=no
.endif

post-install:
.if !defined(NOPORTDOCS)
	@${MKDIR} ${DOCSDIR}
	@${INSTALL_DATA} ${WRKDIR}/${DISTNAME}/doc/${PORTDOCS} ${DOCSDIR}
.endif
.if !defined(NOPORTEXAMPLES)
	@${MKDIR} ${EXAMPLESDIR}
	@${INSTALL_DATA} ${WRKDIR}/${DISTNAME}/sample/${PORTEXAMPLES} ${EXAMPLESDIR}
.endif
	@${MKDIR} ${WWWDIR}
	@${CP} -R ${WRKDIR}/${DISTNAME}/www/ ${WWWDIR}
	@${CHOWN} -R ${WWWOWN}:${WWWGRP} ${WWWDIR}

.include <bsd.port.post.mk>
