/*
 * Easing Compatibility v1 - http://gsgd.co.uk/sandbox/jquery/easing
 *
 * Adds compatibility for applications that use the pre 1.2 easing names
 *
 * Copyright (c) 2007 George Smith
 * Licensed under the MIT License:
 *   http://www.opensource.org/licenses/mit-license.php
 */

(function($) {
    const easingMap = {
        easeIn: 'easeInQuad',
        easeOut: 'easeOutQuad',
        easeInOut: 'easeInOutQuad',
        expoin: 'easeInExpo',
        expoout: 'easeOutExpo',
        expoinout: 'easeInOutExpo',
        bouncein: 'easeInBounce',
        bounceout: 'easeOutBounce',
        bounceinout: 'easeInOutBounce',
        elasin: 'easeInElastic',
        elasout: 'easeOutElastic',
        elasinout: 'easeInOutElastic',
        backin: 'easeInBack',
        backout: 'easeOutBack',
        backinout: 'easeInOutBack'
    };

    // Generic easing function
    const createEasingFunction = (type) => {
        return function (options) {
            const { x, t, b, c, d } = options;
            return $.easing[easingMap[type]](x, t, b, c, d);
        };
    };

    // Extend jQuery easing with the mapped functions
    $.extend($.easing, Object.keys(easingMap).reduce((acc, type) => {
        acc[type] = createEasingFunction(type);
        return acc;
    }, {}));
})(jQuery);
