import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/

extension Project {
    public static func create(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String = "com.didwndckd",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency] = [],
        sources: SourceFilesList = ["Sources/**"],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default,
        settings: Settings? = nil
    ) -> Project {
        // 프로젝트 세팅
        let settings = settings ?? Settings.settings(
            base: [:],
            configurations: [ // Configurations
                .debug(name: .debug),
                .release(name: .release)
            ],
            defaultSettings: .recommended
        )
        
        let target = Target.createWithTests(
            name: name,
            platform: platform,
            product: product,
            organizationName: organizationName,
            deploymentTarget: deploymentTarget,
            scripts: scripts,
            dependencies: dependencies,
            sources: sources,
            resources: resources,
            infoPlist: infoPlist
            )
        
        let schemes: [Scheme] = [.create(target: .debug, name: name)]
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: target.targets,
            schemes: schemes
        )
    }
    
    public static func createCleanArchitecture(
        name: String,
        platform: Platform = .iOS,
        product: Product = .framework,
        organizationName: String = "com.didwndckd",
        packages: [Package] = [],
        deploymentTarget: DeploymentTarget? = .iOS(targetVersion: "14.0", devices: [.iphone, .ipad]),
        dependencies: [TargetDependency] = [],
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist = .default
    ) -> Project {
        let settings = Settings.settings(
            base: [:],
            configurations: [
                .debug(name: .debug),
                .release(name: .release)
            ],
            defaultSettings: .recommended
        )
        
        let domainLayerTarget = Target.createWithTests(name: "\(name)Domain",
                                                       product: .staticLibrary,
                                                       organizationName: organizationName,
                                                       deploymentTarget: deploymentTarget,
                                                       dependencies: [
                                                        .project(
                                                            target: "DomainLayerDependency",
                                                            path: .relativeToRoot("Projects/UserInterface/DomainLayerDependency")
                                                        )
                                                       ] + dependencies,
                                                       sources: ["Domain/**"],
                                                       resources: nil,
                                                       infoPlist: infoPlist)
        
        let dataLayerTarget = Target.createWithTests(name: "\(name)Data",
                                                     product: .staticLibrary,
                                                     organizationName: organizationName,
                                                     deploymentTarget: deploymentTarget,
                                                     dependencies: [
                                                        .target(domainLayerTarget.product),
                                                        
                                                        .project(
                                                            target: "DataLayerDependency",
                                                            path: .relativeToRoot("Projects/UserInterface/DataLayerDependency")
                                                        )
                                                     ],
                                                     sources: ["Data/**"],
                                                     resources: nil,
                                                     infoPlist: infoPlist)
        
        let presentationLayerTarget = Target.createWithTests(name: "\(name)Presentation",
                                                             product: .framework,
                                                             organizationName: organizationName,
                                                             deploymentTarget: deploymentTarget,
                                                             dependencies: [
                                                                .target(dataLayerTarget.product),
                                                                .project(
                                                                    target: "PresentationLayerDependency",
                                                                    path: .relativeToRoot("Projects/UserInterface/PresentationLayerDependency")
                                                                )
                                                             ],
                                                             sources: ["Presentation/**"],
                                                             resources: resources,
                                                             infoPlist: infoPlist)
        
        let productTarget = Target.createWithTests(name: name,
                                                   product: product,
                                                   organizationName: organizationName,
                                                   deploymentTarget: deploymentTarget,
                                                   dependencies: [.target(presentationLayerTarget.product)],
                                                   sources: ["Home/**"],
                                                   resources: nil,
                                                   infoPlist: infoPlist)
        
        let targets = productTarget.targets + domainLayerTarget.targets + dataLayerTarget.targets + presentationLayerTarget.targets
        
        return Project(
            name: name,
            organizationName: organizationName,
            packages: packages,
            settings: settings,
            targets: targets,
            schemes: []
        )
    }
}

struct TargetWithTest {
    let product: Target
    let test: Target
    var targets: [Target] {
        return [product, test]
    }
}

extension Target {
    static func create(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String,
        deploymentTarget: DeploymentTarget?,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency],
        sources: SourceFilesList?,
        resources: ResourceFileElements?,
        infoPlist: InfoPlist
    ) -> Target {
        var scripts = scripts
        scripts.insert(.pre(script: "echo \"😂TEST ->  \(name) START\"", name: "start"), at: 0)
        scripts.append(.post(script: "echo \"😂TEST ->  \(name) END\"", name: "end"))
        
        return Target(
            name: name, // 타겟 이름
            platform: platform, // 플랫폼(iOS, MacOS...)
            product: product, // app, framework, staticLibrary...
            bundleId: "\(organizationName).\(name)", // 번들 아이디
            deploymentTarget: deploymentTarget,
            infoPlist: infoPlist,
            sources: sources, // 소스 경로(프로젝트 루트 기반)
            resources: resources, // 리소스 경로(프로젝트 루트 기반)
            scripts: scripts,
            dependencies: dependencies
        )
    }
    
    static func createWithTests(
        name: String,
        platform: Platform = .iOS,
        product: Product,
        organizationName: String,
        deploymentTarget: DeploymentTarget?,
        scripts: [TargetScript] = [],
        dependencies: [TargetDependency],
        sources: SourceFilesList?,
        resources: ResourceFileElements?,
        infoPlist: InfoPlist
    ) -> TargetWithTest {
        let productTarget = Target.create(
            name: name,
            platform: platform,
            product: product,
            organizationName: organizationName,
            deploymentTarget: deploymentTarget,
            scripts: scripts,
            dependencies: dependencies,
            sources: sources,
            resources: resources,
            infoPlist: infoPlist
        )
        
        let testTarget = Target.create(
            name: "\(name)Tests",
            product: .unitTests,
            organizationName: organizationName,
            deploymentTarget: deploymentTarget,
            dependencies: [.target(name: name)],
            sources: ["Tests/**"],
            resources: nil,
            infoPlist: .default
        )
        
        return TargetWithTest(product: productTarget, test: testTarget)
    }
}

extension Scheme {
    static func create(target: ConfigurationName, name: String) -> Scheme {
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
