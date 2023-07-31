import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    public static func makeModule(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "com.didwndckd",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "15.0", devices: [.iphone, .ipad]),
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {
        // 프로젝트 세팅
        let settings = Settings.settings(
            base: [:], // Build Settings
            configurations: [ // Configurations
                .debug(name: .debug),
                .release(name: .release)
            ],
            defaultSettings: .recommended
        )
        
        let productTarget = Target(
            name: name, // 타겟 이름
            platform: platform, // 플랫폼(iOS, MacOS...)
            product: product, // app, framework, staticLibrary...
            bundleId: "\(organizationName).\(name)", // 번들 아이디
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources, // 소스 경로
            resources: resources, // 리소스 경로
            dependencies: dependencies // 의존성
        )
        
        let testTarget = Target(
            name: "\(name)Tests",
            platform: platform,
            product: .unitTests,
            bundleId: "\(organizationName).\(name)Tests",
            deploymentTarget: deploymentTarget,
            infoPlist: .default,
            sources: ["Tests/**"],
            dependencies: [.target(name: name)]
        )
        
        let schemes: [Scheme] = [.makeScheme(target: .debug, name: name)]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: [productTarget, testTarget],
            schemes: schemes
        )
    }
}

extension Scheme {
    static func makeScheme(target: ConfigurationName, name: String) -> Scheme {
        return Scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            testAction: .targets(
                ["\(name)Test"],
                configuration: target,
                options: .options(coverage: true, codeCoverageTargets: ["\(name)"])
            ),
            runAction: .runAction(configuration: target),
            archiveAction: .archiveAction(configuration: target),
            profileAction: .profileAction(configuration: target),
            analyzeAction: .analyzeAction(configuration: target)
        )
    }
}
